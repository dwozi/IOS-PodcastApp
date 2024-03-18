//
//  favoriteCell.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 18.03.2024.
//

import UIKit


class FavoriteCell : UICollectionViewCell{
    //MARK: - Properties
    private let podcastImageView: UIImageView = {
        let image = UIImageView()
        image.customMode()
        image.layer.cornerRadius = 15
        image.backgroundColor = .purple
        return image
    }()
    private let podcastNameLabel : UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Podcast Name"
        label.textColor = .black
        return label
    }()
    private let podcastArtistNameLabel : UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "Podcast Artist"
        return label
    }()
    private var fullStackview : UIStackView!
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


//MARK: - Helpers
extension FavoriteCell{
    private func style(){
        fullStackview = UIStackView(arrangedSubviews: [podcastImageView,podcastNameLabel,podcastArtistNameLabel])
        fullStackview.axis = .vertical
        fullStackview.distribution = .equalSpacing
        fullStackview.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    private func layout(){
        addSubview(fullStackview)
        NSLayoutConstraint.activate([
            podcastImageView.heightAnchor.constraint(equalTo: podcastImageView.widthAnchor),
            
            fullStackview.topAnchor.constraint(equalTo: topAnchor),
            fullStackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackview.trailingAnchor.constraint(equalTo: trailingAnchor),
            fullStackview.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        
        ])
    }
}
