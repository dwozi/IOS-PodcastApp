//
//  FavoriteViewController.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit
private let reuseIdentifier = "favoriteCell"

class FavoriteViewController : UICollectionViewController{
//MARK: - Properties
    private var resultCoreDataItems : [PodcastsData] = []{
        didSet{
            collectionView.reloadData()
        }
    }
//MARK: - Lifecycle
    
    init() {
        let flowlayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowlayout)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Badge Value reset
        let window = UIApplication.shared.connectedScenes.first as! UIWindowScene
        let mainTabController = window.keyWindow?.rootViewController as! MainTabBarController
        mainTabController.viewControllers?[0].tabBarItem.badgeValue = nil
       
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Helpers
extension FavoriteViewController{
    
    private func fetchData(){
        let fetchRequest = PodcastsData.fetchRequest()
        
        CoreDataController.fetchCoreData(fetchRequest: fetchRequest) { values in
            self.resultCoreDataItems = values
        }
    }
    private func setup(){
        view.backgroundColor = .systemCyan
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
}

//MARK: - UI COLLECTION VIEW DATA SOURCE

extension FavoriteViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultCoreDataItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.podcastCoreData = self.resultCoreDataItems[indexPath.row]
        return cell
    }
    
    
}
//MARK: - UIcollectionViewDelegate
extension FavoriteViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episodeCoreData = self.resultCoreDataItems[indexPath.row]
        let podcasts = Podcast(trackName: episodeCoreData.trackName,artistName: episodeCoreData.artistName,imageUrl: episodeCoreData.imageUrl,feedUrl: episodeCoreData.feedUrl)
       
        let controller = EpisodeViewController(podcast: podcasts)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
//MARK: - UICollectionViewDelegateFlowlayout
extension FavoriteViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30) / 2
        return .init(width: width, height: width+50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10 , left: 10, bottom: 10, right: 10)
    }
}
