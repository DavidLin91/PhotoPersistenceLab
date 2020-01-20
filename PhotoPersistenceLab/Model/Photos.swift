//
//  Photos.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/19/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation

struct AllPhotos: Codable {
    let hits: [Photos]
}

struct Photos: Codable {
    let largeImageURL: String
    let tags: String
    let likes: Int
    let userImageURL: String
    let previewURL: String
}
