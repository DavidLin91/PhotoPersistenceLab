//
//  SelectedPhotoVC.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/19/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class SelectedPhotoDVC: UIViewController {
    @IBOutlet weak var largePhoto: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var photoTags: UILabel!
    @IBOutlet weak var detailedCollectionView: UICollectionView!
    
    var detailedPhoto: Photos!
    
    var photos = [Photos]() {
        didSet{
            DispatchQueue.main.async {
                self.detailedCollectionView.reloadData()
            }
        }
    }
    
    let searchQuery = "sushi"
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //detailedCollectionView.dataSource = self
        updateUI()
        loadData(search: searchQuery)
    }
    
    func loadData(search: String) {
        PhotosAPIClient.getPhotos(with: search) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self.photos = data
            }
        }
    }
    
    func updateUI() {
        likesLabel.text = "Likes: \(detailedPhoto.likes.description)"
        photoTags.text = detailedPhoto.tags
        
        let imageURL = detailedPhoto.largeImageURL.description
        
        largePhoto.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.largePhoto.image = image
                }
            }
        }
    }
}

//extension SelectedPhotoDVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        photos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailedPhotoCell", for: indexPath) as? PhotoCell else {
//            fatalError()
//        }
//        let photo = photos[indexPath.row]
//        cell.updateUI(photo: photo )
//        return cell
//    }
//}
