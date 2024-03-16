//
//  SearchCell.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

class SearchCell : UITableViewCell{
    //MARK: - Properties
    private let photoImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPurple
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let trackName: UILabel = {
       let label = UILabel()
        label.text = "Track Name"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    private let artistName: UILabel = {
       let label = UILabel()
        label.text = "Artist Name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private let trackCount: UILabel = {
       let label = UILabel()
        label.text = "Track Count"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    private var stackView : UIStackView!
    
    
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//MARK: -Helpers
extension SearchCell {
    private func setup(){

        stackView = UIStackView(arrangedSubviews: [trackName,artistName,trackCount])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 5
    }
    
    private func layout(){
        //MARK: - Subviews
        addSubview(photoImageView)
        addSubview(stackView)
        
        
        //MARK: - add Constraints
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 4),
           
            stackView.centerYAnchor.constraint(equalTo:  photoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
