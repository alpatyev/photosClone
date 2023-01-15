//
//  PhotosDataModel.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/12/23.
//

import Foundation

// MARK: - Common entities as an example

struct PDImage: Codable {
    var imageName: String
    var imageFileName: String
}

struct PDAlbum: Codable {
    var name: String
    var images = [PDImage]()
}

struct PDAlbumsStorage: Codable {
    fileprivate var list = [PDAlbum]()
}

// MARK: - Interact with datasource

final class PhotosDataManager {
    
    // MARK: Single instance
    
    static fileprivate var storage = PDAlbumsStorage()
    
    static var imageModelPath: String?
    
    // MARK: Open methods
        
    static func deleteAlbum(at index: Int) {
        guard (index > 1) && (index < PhotosDataManager.storage.list.count) else {
            return
        }
        PhotosDataManager.storage.list.remove(at: index)
    }
    
    static func createAlbum(_ named: String) {
        PhotosDataManager.storage.list.append(PDAlbum(name: named))
    }
    
    static func moveAlbum(from index: Int, to otherIndex: Int) {
        print("In develop")
    }
    
    static func fetchImages(_ named: String = "imageModel") {
        guard let filePath = Bundle.main.path(forResource: named, ofType: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            if let result = try? JSONDecoder().decode(PDAlbumsStorage.self, from: data) {
                storage.list = result.list
            }
        } catch {
            return
        }
    }
    
    static func saveImages(_ named: String = "imageModel", object: [PDAlbum] = storage.list) {
        guard let filePath = Bundle.main.path(forResource: named, ofType: "json") else {
            return
        }
            
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if let encodedData = try? encoder.encode(object) {
            do {
                try encodedData.write(to: URL(fileURLWithPath: filePath))
            }
            catch {
                return
            }
        }
    }
}
