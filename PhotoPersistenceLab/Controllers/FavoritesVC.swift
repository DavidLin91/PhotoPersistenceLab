//
//  FavoritesVC.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/19/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import UIKit
import ImageKit

class FavoritesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favoritePhotos = [Photos]() {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadFavorites()
    }
    
    func loadFavorites() {
        do {
           favoritePhotos = try PersistenceHelper.loadPhotos()
        } catch {
            print("could not load data")
        }
    }
    

}

extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let photo = favoritePhotos[indexPath.row]
        cell.textLabel?.text = photo.tags
        cell.imageView?.getImage(with: photo.largeImageURL, completion: { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView!.image = image
                }
            }
        })
        return cell
    }
}

