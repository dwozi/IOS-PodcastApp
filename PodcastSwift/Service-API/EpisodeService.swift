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
}
