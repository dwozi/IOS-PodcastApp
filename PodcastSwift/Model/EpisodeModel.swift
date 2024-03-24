//
//  EpisodeModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import FeedKit

struct EpisodeModel : Codable{
    let title : String
    let pubDate : Date
    let description : String
    let image : String
    let streamUrl : String
    let author : String
    var fileUrl : String?
    
    init(value: RSSFeedItem) {
        self.author = value.iTunes?.iTunesAuthor?.description ?? value.author ?? ""
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.streamUrl = value.enclosure?.attributes?.url ?? ""
        self.description = value.iTunes?.iTunesSubtitle ??  value.description ?? ""
        self.image = value.iTunes?.iTunesImage?.attributes?.href ?? "https://cdn.pixabay.com/photo/2018/09/23/00/09/podcast-3696504_1280.jpg"
    }
}
