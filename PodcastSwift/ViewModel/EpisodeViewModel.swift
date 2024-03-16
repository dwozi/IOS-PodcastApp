//
//  EpisodeViewModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation

struct EpisodeViewModel{
    let episode : EpisodeModel
    init(episode: EpisodeModel) {
        self.episode = episode
    }
    
    var profileImageUrl : URL?{
        return URL(string: episode.image)
    }
    var title : String?{
        return episode.title
    }
    var description : String{
        return episode.description
    }
    
    var pubDate : String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyy"
        return dateFormatter.string(from: episode.pubDate)
    }
}
