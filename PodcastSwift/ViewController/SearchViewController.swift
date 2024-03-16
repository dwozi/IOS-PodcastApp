//
//  SearchViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
import Alamofire
import Kingfisher

private let reuseIdentifier = "searchCell"

class SearchViewController : UITableViewController{
//MARK: - Properties
    
    var searchResult : [Podcast] = []{
        didSet{
            tableView.reloadData()
        }
    }
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchService.fetchData(searchText: "yazılım") { result in
            self.searchResult = result
        }
        style()
        layout()
    }
}

//MARK: - Helpers
extension SearchViewController{
    private func style(){
    
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 100
        //MARK: - Searchbar
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self

    }
    private func layout(){
        
    }
}

//MARK: - UIableViewDataSource

extension SearchViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.result = self.searchResult[indexPath.row]
        return  cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = self.searchResult[indexPath.row]
        let controller = EpisodeViewController(podcast: podcast)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: -UITableViewDelegate
extension SearchViewController{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Search Start.."
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle2)
        label.textColor = .systemPurple
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.searchResult.count == 0 ? 80 : 0
    }
}


//MARK: - SearchbarDelegate
extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchService.fetchData(searchText: searchText) { podcasts in
            self.searchResult = podcasts
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchResult = []
    }
}
