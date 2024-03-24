//
//  EpisodeService.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import FeedKit
import Alamofire
struct EpisodeService{
    static func fetchData(urlString:String,completion: @escaping([EpisodeModel]) -> Void){
        var episodeResult : [EpisodeModel] = []
        
        let feedkit = FeedParser(URL: URL(string: urlString)!)
        feedkit.parseAsync { result in
            switch result {
          
            case .failure(let error):
                print(error.localizedDescription)
           
            case .success(let feed):
                switch feed{
                    
                case .atom(_):
                    break
                case .rss(let feedResult):
                    feedResult.items?.forEach({ value in
                        let episodeCell = EpisodeModel(value: value)
                        episodeResult.append(episodeCell)
                        completion(episodeResult)
                    })
                case .json(_):
                    break
                }
                
            }
        }
    }
    
    
    static func downloasdEpisodes(episode:EpisodeModel){
        let downloadRequest = DownloadRequest.suggestedDownloadDestination()
        AF.download(episode.streamUrl,to: downloadRequest).downloadProgress { progress in
            let progressValue = progress.fractionCompleted
            NotificationCenter.default.post(name: .downloadNotificationName, object: nil,userInfo: ["Title":episode.title,"Progress":progressValue])
        }.response { response in
        
            var downloadEpisodeResponse = UserDefaults.downloadEpisodeRead()
            let index = downloadEpisodeResponse.firstIndex(where: {$0.author == episode.author && $0.streamUrl == episode.streamUrl})
            downloadEpisodeResponse[index!].fileUrl = response.fileURL?.absoluteString
         
            do{
                let data =  try JSONEncoder().encode(downloadEpisodeResponse)
                UserDefaults.standard.setValue(data, forKey: UserDefaults.downloadKey)
            }catch{
                
            }
        }
        
    }
}
    
