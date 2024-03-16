//
//  EpisodeService.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import FeedKit
struct EpisodeService{
    static func fetchData(urlString:String){
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
                        print(value.title)
                    })
                case .json(_):
                    break
                }
                
            }
        }
    }
}
