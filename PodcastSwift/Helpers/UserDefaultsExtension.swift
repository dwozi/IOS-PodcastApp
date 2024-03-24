//
//  UserDefaultsExtension.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 19.03.2024.
//

import Foundation


extension UserDefaults{
    static let downloadKey = "downloadKey"
    static func downloadEpisodeWrite(episode:EpisodeModel){
        do {
            var resultsEpisodes = downloadEpisodeRead()
            resultsEpisodes.append(episode)
            let data = try JSONEncoder().encode(resultsEpisodes)
            UserDefaults.standard.setValue(data, forKey: downloadKey)
            
        } catch  {
            
        }
    }
    static func downloadEpisodeRead() -> [EpisodeModel]{
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.downloadKey) else {return [] }
        do {
            let resultData = try JSONDecoder().decode([EpisodeModel].self, from: data)
            return resultData
        } catch  {
            
        }
        
        return []
    }
}
