//
//  PersistanceHelper.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/20/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation

enum dataPersistenceError: Error { // conforming to the Error Protocol
    case savingError(Error) // associated value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    // CRUD - create, read, update, delete
    
    // array of events
    private static var photos = [Photos]()
    
    private static let filename = "schedules.plist"
    
    // create - save item to documents directory
    static func save(photo: Photos) throws {
        
        // STEP 2
        // append new event to the events array
        photos.append(photo)
        
        do {
            try save()
        } catch {
            throw dataPersistenceError.savingError(error)
        }
    }
    
    
    
    private static func save() throws {
        // STEP 1
        // get url to path to the file that the event will be saved to
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // events arrray will be object being converted to Data
        // we will use the Data object to and write (save) it to documents
        do {
            
            // STEP 3
            // convert (serialize) the events array to data
            let data = try PropertyListEncoder().encode(photos)
            
            //STEP 4
            // writes, saves, persists the data to the documentsdirectory
            try data.write(to: url, options: .atomic)
        } catch {
            // STEP 5
            throw dataPersistenceError.savingError(error)
        }
        
        
    }
    
    
    
    // read - load (retrieve) items from documents directory
    static func loadPhotos() throws -> [Photos] {
        // we need access to the filename URL that wea re reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        
        // check if file exists
        // to convert URL to string, we use .path on the URL
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    photos = try PropertyListDecoder().decode([Photos].self, from: data)
                } catch {
                    throw dataPersistenceError.decodingError(error)
                    
                }
            } else {
                throw dataPersistenceError.noData
            }
        } else {
            throw dataPersistenceError.fileDoesNotExist(filename)
        }
        return photos
    }
    
    // update -
    
    
    
    
    // delete - remove item from documents directory
    static func delete(event index: Int)  throws {
        // remove the item from the events array
        photos.remove(at: index)
        
        //save our events array to the documents directory
        do {
            try save()
        } catch {
            throw dataPersistenceError.deletingError(error)
        }
    }
}


