//
//  SearchModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation

struct SearchModel : Decodable{
    
    let resultCount: Int
    let results: [Podcast]
}



struct Podcast : Decodable{
    var trackName: String?
    var artistName: String?
    var trackCount : Int?
    var imageUrl : String?
    var feedUrl : String?
    
    private enum CodingKeys : String ,CodingKey{
        case imageUrl = "artworkUrl600"
        case trackName = "trackName"
        case artistName = "artistName"
        case trackCount = "trackCount"
        case feedUrl = "feedUrl"

       
    }
}
