//
//  SearchViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
import Alamofire

private let reuseIdentifier = "searchCell"

class SearchViewController : UITableViewController{
//MARK: - Properties
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension SearchViewController{
    private func style(){
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemRed
        
        return  cell
    }
    
}

//MARK: - SearchbarVC
extension SearchViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        AF.request("https://itunes.apple.com/search?term=jack+johnson").response { response in
            print(String(data: response.data!, encoding: .utf8))
        }
        print(searchText)
    }
}
