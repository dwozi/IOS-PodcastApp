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
    private var mainStackView : UIStackView!
    private var timerStackView : UIStackView!
    private var playStackView : UIStackView!
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let episodeImage : UIImageView = {
       let image = UIImageView()
        image.customMode()
        image.backgroundColor = .systemPurple
        return image
    }()
    
    private let sliderView : UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal) // video slider
        return slider
    }()
    
    private let startLabel : UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .left
        return label
        
    }()
    private let endLabel : UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .right
        return label
    }()
    private let podcastLabel : UILabel = {
       let label = UILabel()
        label.text = "name"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        return label
    }()
    private let userLabel : UILabel = {
        let label = UILabel()
        label.text = "user"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var goForWard: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "goforward.15"), for: .normal)
        return button
    }()
    private lazy var goPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        return button
    }()
    private lazy var goBackWard: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.configuration?.baseForegroundColor = .systemBlue
        button.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        
        return button
    }()
    private var movingStackView : UIStackView!
 
    
    private let movingSlider : UISlider = {
        let slider = UISlider()
        return slider
    }()
    private let plusImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "speaker.wave.3.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .secondaryLabel
        return image
    }()
    
    private let minusImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "speaker.wave.1.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .secondaryLabel
        

        return image
    }()
 
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
        
        view.backgroundColor = .systemBackground
        
        timerStackView = UIStackView(arrangedSubviews: [startLabel,endLabel])
        timerStackView.axis = .horizontal
        
        playStackView = UIStackView(arrangedSubviews: [goBackWard,goPlayButton,goForWard])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        playStackView.spacing = 60
        
        movingStackView = UIStackView(arrangedSubviews: [minusImageView,movingSlider,plusImageView])
        movingStackView.axis = .horizontal
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton,episodeImage,sliderView,timerStackView,podcastLabel,userLabel,playStackView,movingStackView])
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    }
                
    private func layout(){
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            episodeImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            sliderView.heightAnchor.constraint(equalToConstant: 40),
            
            playStackView.heightAnchor.constraint(equalToConstant: 120),
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:  -32),
            
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
           
    }
                
                
               
}
