//
//  FavoriteViewModel.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 18.03.2024.
//

import Foundation
struct FavoriteViewModel{
    let favoriteModel : PodcastsData!
    init(favoriteModel : PodcastsData!) {
        self.favoriteModel = favoriteModel
    }
    
    var imageUrl : URL?{
        return URL(string: favoriteModel.imageUrl!)
    }
    
    var name : String?{
        return favoriteModel.artistName
    }
    var podName : String?{
        return favoriteModel.trackName
    }
    
    
}
