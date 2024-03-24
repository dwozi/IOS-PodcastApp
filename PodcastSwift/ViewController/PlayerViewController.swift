//
//  PlayerViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
import AVKit
import Alamofire

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
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    private let episodeImage : UIImageView = {
       let image = UIImageView()
        image.customMode()
        image.backgroundColor = .systemPurple
        image.layer.cornerRadius = 10
        
        return image
    }()
    
    private let sliderView : UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal) // video slider
        return slider
    }()
    
    private let startLabel : UILabel = {
       let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .left
        return label
        
    }()
    private let endLabel : UILabel = {
       let label = UILabel()
        label.text = "00 : 00"
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
        button.addTarget(self, action: #selector(handleGoForWardButton), for: .touchUpInside)
        return button
    }()
    private lazy var goPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleGoPlayButton), for: .touchUpInside)
        return button
    }()
    private lazy var goBackWard: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .secondaryLabel
        button.configuration?.baseForegroundColor = .systemBlue
        button.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        button.addTarget(self, action: #selector(handleBackForWardButton), for: .touchUpInside)
        
        return button
    }()
    private var movingStackView : UIStackView!
 
    
    private lazy var movingSlider : UISlider = {
        let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(handleVolumeSliderView), for: .valueChanged)
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
    private let player : AVPlayer = {
       let player = AVPlayer()
        
        return player
    }()
 
    //MARK: - Lifecycle
    init(episode:EpisodeModel) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        startPlay()
        configureUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        player.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Selectors

extension PlayerViewController{
    
    @objc private func handleVolumeSliderView(_ sender: UISlider){
        player.volume = sender.value
    }
    
    
    @objc private func handleGoForWardButton(_ sender: UIButton){
        updateForward(value: 15)
    }
    
    @objc private func handleBackForWardButton(_ sender: UIButton){
        updateForward(value: -15)
    }
    
    @objc private func handleGoPlayButton(_ sender: UIButton){
        if player.timeControlStatus == .paused{
            player.play()
            self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else{
            player.pause()
            self.goPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        }
    }
    @objc private func handleCloseButton(_ sender: UIButton){
        self.dismiss(animated: true)
        player.pause()
    }
}

//MARK: - Helper
extension PlayerViewController{
    
    
    private func updateForward(value:Int64){
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), exampleTime)
        player.seek(to: seekTime)
    }
    
    fileprivate func updateSlider(){
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.sliderView.value = Float(resultSecondTime)
    }
    
    fileprivate func updateTimeLabel(){
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
           
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration //podcast timer work with extension
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
        }
    }
    
    private func configureUI(){
        self.episodeImage.kf.setImage(with: URL(string: episode.image))
        self.podcastLabel.text = episode.title
        self.userLabel.text = episode.author
    }
    private func playPlayer(url:URL){
        
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.movingSlider.value = 40
        updateTimeLabel()
    }
    private func startPlay(){
        if episode.fileUrl != nil {
            guard let url = URL(string: episode.fileUrl ?? "") else{return}
            guard var fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            fileURL.append(path: url.lastPathComponent)
            playPlayer(url: fileURL)
            return
        }
        
        guard let url = URL(string: episode.streamUrl) else { return}
        playPlayer(url: url)
       
        
    }
    
    private func style(){
        
        view.backgroundColor = .systemBackground
        
        timerStackView = UIStackView(arrangedSubviews: [startLabel,endLabel])
        timerStackView.axis = .horizontal
        
        let fullTimerStackView = UIStackView(arrangedSubviews: [sliderView,timerStackView])
        fullTimerStackView.axis = .vertical
        
        playStackView = UIStackView(arrangedSubviews: [goBackWard,goPlayButton,goForWard])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        playStackView.spacing = 60
        
        movingStackView = UIStackView(arrangedSubviews: [minusImageView,movingSlider,plusImageView])
        movingStackView.axis = .horizontal
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton,episodeImage,fullTimerStackView,podcastLabel,userLabel,playStackView,movingStackView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
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
