//
//  EpisodeCell.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

class EpisodeCell : UITableViewCell{
    //MARK: - Properties
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}

//MARK: - Helpers
extension EpisodeCell{
    private func setup(){
        backgroundColor = .systemMint
    }
}
