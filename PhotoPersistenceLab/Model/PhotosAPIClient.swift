//
//  PhotosAPIClient.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/19/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation
import NetworkHelper


struct PhotosAPIClient {
    static func getPhotos(with search: String, completion: @escaping(Result<[AllPhotos], AppError>) -> ()) {
        let endpointURLString = "https://pixabay.com/api/?key=14969843-2cae0700ee723f2830a9ec598&q=\(search)"
        
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url:url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let projects = try JSONDecoder().decode([AllPhotos].self, from: data)
                    completion(.success(projects))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
