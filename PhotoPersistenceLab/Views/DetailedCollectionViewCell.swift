//
//  DetailedCollectionViewCell.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/20/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit
import ImageKit

class DetailedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    
    func updateUI(photo: Photos){
        let imageURL = photo.previewURL.description
        
        photoImage.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.photoImage.image = image
                }
            }
        }
    }
}
