//
//  PlayerViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

class PlayerViewController: UIViewController{
    //MARK: - Properties
    var episode: EpisodeModel
    //MARK: - Lifecycle
    init(episode:EpisodeModel) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helper
extension PlayerViewController{
    private func style(){
        view.backgroundColor = .systemRed
        print(episode.title)
    }
    private func layout(){
        
    }
}
