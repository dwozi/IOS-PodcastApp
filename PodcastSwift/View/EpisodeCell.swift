//
//  EpisodeCell.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
import Kingfisher

class EpisodeCell : UITableViewCell{
    
    var result : EpisodeModel?{
        didSet{
            configure()
        }
    }
    
    //MARK: - Properties
      var progressView : UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .lightGray
        progress.tintColor = .systemPurple
        progress.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        progress.layer.cornerRadius = 10
        progress.setProgress(Float(0), animated: true)
        
        progress.isHidden = true
        
        return progress
    }()
    private let episodeImageView : UIImageView = {
       let image = UIImageView()
        image.customMode()
        image.backgroundColor = . systemPurple
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let pubDateLabel : UILabel = {
       let label = UILabel()
        label.textColor = .purple
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
        stackView.spacing = 5
        
        addSubview(stackView)
        addSubview(progressView)

        
        //ProgressView
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Constraints
        NSLayoutConstraint.activate([
        
            episodeImageView.heightAnchor.constraint(equalToConstant: 100),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            progressView.heightAnchor.constraint(equalToConstant: 20),
            progressView.leadingAnchor.constraint(equalTo: episodeImageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: episodeImageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: episodeImageView.bottomAnchor),
            
            
            stackView.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
            
        
        
        ])
    }
    
    private func configure(){
        guard let result = self.result else {return}
        let episodeVM = EpisodeViewModel(episode: result)
        self.titleLabel.text = episodeVM.title
        self.descriptionLabel.text = episodeVM.description
        self.episodeImageView.kf.setImage(with: episodeVM.profileImageUrl)
        self.pubDateLabel.text = episodeVM.pubDate
        
    }
}
