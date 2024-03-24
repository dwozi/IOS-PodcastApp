//
//  EpisodeViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

private let reuseIdentifier = "EpisodeCell"

//MARK: - CoreData


class EpisodeViewController : UITableViewController{
    //MARK: - Properties
  
    
    private var podcast : Podcast
    private var episodeResult : [EpisodeModel] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    private var isFavorite = false{
        didSet{
            setupNavBarItem()
        }
    }
    
    private var resultCoreDataItems: [PodcastsData] = []{
        didSet{
            let isValue = resultCoreDataItems.contains(where: {$0.feedUrl == self.podcast.feedUrl})
            if isValue{
                isFavorite = true
            }else{
                isFavorite = false
            }
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
        if isFavorite{
            deleteCoreData()
        }else{
            addCoreData()
        }
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
    private func addCoreData(){
        let model = PodcastsData(context: context)
        CoreDataController.addCoreData(model: model, podcast: self.podcast)
        isFavorite = true
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarController
        mainTabController.viewControllers?[0].tabBarItem.badgeValue = "New"
    }
    private func deleteCoreData(){
        CoreDataController.deleteCoreData(values: resultCoreDataItems, podcast: podcast)
        self.isFavorite = false
    }
    
    private func fetchCoreData(){
        let fetchRequest = PodcastsData.fetchRequest()
        
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { values in
            self.resultCoreDataItems = values
        }
        
    }
    private func setupNavBarItem(){
        if isFavorite{
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill")?.withTintColor(.red,renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = navRightItem
        }else{
            let navRightItem = UIBarButtonItem(image: UIImage(systemName: "heart")?.withTintColor(.red,renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleFavoriteButton))
            self.navigationItem.rightBarButtonItem = navRightItem
        }
    }
    
    
    
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .systemBackground
        setupNavBarItem()
        fetchCoreData()
        
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
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let downloadAction = UIContextualAction(style: .normal, title: "Download") { action, view, bool in
            print("item info: \(self.episodeResult[indexPath.row])")
            UserDefaults.downloadEpisodeWrite(episode: self.episodeResult[indexPath.row])
            bool(true)
            print(UserDefaults.downloadEpisodeRead())
        }
        downloadAction.backgroundColor = .systemPurple
        let configuration = UISwipeActionsConfiguration(actions: [downloadAction])
        return configuration
    }
}
