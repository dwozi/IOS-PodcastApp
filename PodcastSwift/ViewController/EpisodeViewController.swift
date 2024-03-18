//
//  EpisodeViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
private let reuseIdentifier = "EpisodeCell"
class EpisodeViewController : UITableViewController{
    //MARK: - Properties
    private var podcast : Podcast
    private var episodeResult : [EpisodeModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    //MARK: - Lifecycle
    init(podcast: Podcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}

//MARK: - Selectors
extension EpisodeViewController{
    
    @objc func handleFavoriteButton(){
        print("Favourite")
    }
}
//MARK: - Service
extension EpisodeViewController{
    fileprivate func fetchData(){
        EpisodeService.fetchData(urlString: self.podcast.feedUrl!) { result in
            DispatchQueue.main.async{
                self.episodeResult = result
                
            }
            
        }
    }
}

//MARK: - Helpers
extension EpisodeViewController{
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .systemBackground
        
        let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(handleFavoriteButton))
        self.navigationItem.rightBarButtonItems = [navRightItem]
    }
}

//MARK: - UItableViewDataSource
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        cell.result = self.episodeResult[indexPath.row]
        return cell
    }
}

//MARK: - UItableViewDelegate
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEpisode = self.episodeResult[indexPath.row]
        let controller = PlayerViewController(episode: selectedEpisode)
        self.present(controller, animated: true)
    }
}
