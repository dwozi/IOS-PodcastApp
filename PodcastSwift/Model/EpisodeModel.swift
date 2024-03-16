//
//  EpisodeModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import FeedKit

struct EpisodeModel{
    var title : String
    var pubDate : Date
    var description : String
    
    init(value: RSSFeedItem) {
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.description = value.description ?? ""
    }
}
