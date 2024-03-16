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
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
    }
}
//MARK: - Helpers
extension EpisodeViewController{
 
    private func setup(){
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
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
