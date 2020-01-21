//
//  ViewController.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/19/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var photos = [Photos]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "dog" {
        didSet {
            searchPhoto(search: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        searchBar.delegate = self
        searchPhoto(search: searchQuery)
    }
    
    func searchPhoto(search: String) {
        PhotosAPIClient.getPhotos(with: search) {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let data):
                self?.photos = data
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedSearchVC = segue.destination as? SelectedPhotoDVC,
            let indexPath = collectionView.indexPathsForSelectedItems?.first else {
                fatalError()
        }
        let photo = photos[indexPath.row]
        detailedSearchVC.detailedPhoto = photo
        detailedSearchVC.searchQueryDVC = searchQuery
    }
    
    
    
    
    
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError()
        }
        
        let photo = photos[indexPath.row]
        cell.updateUI(photo: photo )
        return cell
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchPhoto(search: searchText)
    }
}
