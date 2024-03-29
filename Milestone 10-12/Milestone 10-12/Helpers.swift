//
//  Helpers.swift
//  Milestone 10-12
//
//  Created by Diana on 16/08/2023.
//

import Foundation

class Helpers {
    
    static var picturesKey = "Pictures"
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func getImageURL(for imageName: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(imageName)
    }
    
    // run in background thread
    static func savePictures(pictures: [Picture]) {
        if let encodedPictures = try? JSONEncoder().encode(pictures) {
            UserDefaults.standard.set(encodedPictures, forKey: picturesKey)
        }
    }
    
    // run in background thread
    static func loadPictures() -> [Picture] {
        if let loadedPictures = UserDefaults.standard.object(forKey: picturesKey) as? Data {
            if let decodedPictures = try? JSONDecoder().decode([Picture].self, from: loadedPictures) {
                return decodedPictures
            }
        }
        
        return [Picture]()
    }
}
