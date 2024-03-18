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
//MARK: - Lifecycle
    
    init() {
        let flowlayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowlayout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension FavoriteViewController{
    private func setup(){
        view.backgroundColor = .systemCyan
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
}

//MARK: - UI COLLECTION VIEW DATA SOURCE

extension FavoriteViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FavoriteViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width - 30) / 2, height: (view.frame.width-30) / 2)
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
