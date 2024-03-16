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
//MARK: - Service
extension EpisodeViewController{
    fileprivate func fetchData(){
        EpisodeService.fetchData(urlString: self.podcast.feedUrl!)
    }
}

//MARK: - Helpers
extension EpisodeViewController{
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.backgroundColor = .systemBackground
    }
}

//MARK: - UItableViewDataSource
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        
        return cell
    }
}

//MARK: - UItableViewDelegate
extension EpisodeViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}