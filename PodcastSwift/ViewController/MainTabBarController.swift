//
//  MainTabBarController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import Foundation
import UIKit
class MainTabBarController : UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


//MARK: - Helper

extension MainTabBarController{
    private func setup(){
        
        
        viewControllers = [
            createViewController(rootViewController: FavoriteViewController(), title: "Favourites", imagename: "star.fill"),
            
            createViewController(rootViewController: SearchViewController(), title: "Search", imagename: "magnifyingglass"),
            
            createViewController(rootViewController: DownloadsViewController(), title: "Downloads", imagename: "square.and.arrow.down"),
            
        ]
    }
    
    private func createViewController(rootViewController:UIViewController,title:String,imagename:String) -> UINavigationController{
        
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        let controller = UINavigationController(rootViewController: rootViewController)
        
        controller.navigationBar.prefersLargeTitles = true
        
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imagename)
        
        colorChange()
        
        
        return controller
    }
    
    
    private func colorChange(){
        
        
        // Tab bar'ın seçilen öğeler için rengini ayarla
        UITabBar.appearance().tintColor = .purple
        
        // Tab bar öğelerinin metin rengini ayarla
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.purple], for: .selected)
    }
}
