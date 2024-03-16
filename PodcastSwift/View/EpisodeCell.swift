//
//  EpisodeCell.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

class EpisodeCell : UITableViewCell{
    
    var result : EpisodeModel?{
        didSet{
            configure()
        }
    }
    
    //MARK: - Properties
    private let episodeImageView : UIImageView = {
       let image = UIImageView()
        image.customMode()
        image.backgroundColor = . systemPurple
        return image
    }()
    
    private let pubDateLabel : UILabel = {
       let label = UILabel()
        label.textColor = .systemPurple
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "pubDate Label"
        return label
    }()
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.text = "Title Label"
        return label
    }()
    private let descriptionLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.text = "Title Label"
        return label
    }()
    private var stackView : UIStackView!
    
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
        configureUI()
    }
    
    private func configureUI(){
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeImageView)
        
        //StackView
        stackView = UIStackView(arrangedSubviews: [pubDateLabel,titleLabel,descriptionLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        
        //Constraints
        NSLayoutConstraint.activate([
        
            episodeImageView.heightAnchor.constraint(equalToConstant: 100),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            stackView.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        
        
        ])
    }
    
    private func configure(){
        guard let result = self.result else {return}
        self.titleLabel.text = result.title
        self.descriptionLabel.text = result.description
        
    }
}
