//
//  SearchViewModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation

struct SearchViewModel{
    let podcast: Podcast
    init(podcast: Podcast) {
        self.podcast = podcast
    }
    var photoImageUrl : URL?{
        return URL(string: podcast.imageUrl ?? "")
    }
    var trackCountString : String?{
        return "\(podcast.trackCount ?? 0)"
    }
    var artistName : String?{
        return podcast.artistName
    }
    var trackName: String?{
        return podcast.trackName
    }
}
