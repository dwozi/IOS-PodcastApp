//
//  EpisodeModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import FeedKit

struct EpisodeModel{
    let title : String
    let pubDate : Date
    let description : String
    let image : String
    
    init(value: RSSFeedItem) {
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.description = value.iTunes?.iTunesSubtitle ??  value.description ?? ""
        self.image = value.iTunes?.iTunesImage?.attributes?.href ?? "https://cdn.pixabay.com/photo/2018/09/23/00/09/podcast-3696504_1280.jpg"
    }
}
