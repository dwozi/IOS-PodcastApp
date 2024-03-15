//
//  FavoriteViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

class FavoriteViewController : UIViewController{
//MARK: - Properties
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Helpers
extension FavoriteViewController{
    private func style(){
        view.backgroundColor = .systemCyan

    }
    private func layout(){
        
    }
}
