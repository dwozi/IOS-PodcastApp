//
//  DownloadsViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

private let reuseIdentifier = "downloadCell"

class DownloadsViewController : UITableViewController{
//MARK: - Properties
    
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: - Helpers
extension DownloadsViewController{
    private func setup(){
        view.backgroundColor = .systemBackground
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
}

//MARK: - UITableViewDataSource
extension DownloadsViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        return cell
    }
    
}


//MARK: - UITableViewDelegate
extension DownloadsViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
