//
//  FileManager+Extensions.swift
//  PhotoPersistenceLab
//
//  Created by David Lin on 1/21/20.
//  Copyright © 2020 David Lin (Passion Proj). All rights reserved.
//

import Foundation

extension FileManager {
    
    // function gets URL path to documents directory
    // FileManager.getDocumentsDirectory()
    static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // documents/schedules.plist "schedules.plist"
    static func pathToDocumentsDirectory(with filename: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
