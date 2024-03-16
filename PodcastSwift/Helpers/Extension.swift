//
//  Extension.swift
//  PodcastSwift
//
//  Created by Hakan Hardal on 16.03.2024.
//

import UIKit

extension UIImageView{
    func customMode(){
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        
    }
}
