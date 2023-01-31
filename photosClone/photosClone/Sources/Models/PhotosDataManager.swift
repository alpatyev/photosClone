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
    
    static func selectedItem(at indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                print("My Albums: at \(indexPath.row)")
            case 1:
                if indexPath.row == 0 {
                    print("People & Places: People")
                } else if indexPath.row == 1 {
                    print("People & Places: Places")
                }
            case 2:
                print("Utilities: Imports")
            case 3:
                print("Utilities: Hidden")
            default:
                print("Utilities: Recently Deleted")
        }
    }
    
    static func createUtilitiesCellModel(for line: Int) -> UtilitiesModel? {
        switch line {
            case 2:
                return UtilitiesModel(image: "imports",
                                      title: "Imports")
            case 3:
                return UtilitiesModel(image: "hidden",
                                      title: "Hidden")
            case 4:
                return UtilitiesModel(image: "deleted",
                                      title: "Recently Deleted",
                                      divider: false)
            default:
                return nil
        }
    }
    
    static func getAlbumsCount() -> Int {
        PhotosDataManager.storage.list.count
    }
    
    static func getPeopleCellData() -> [String] {
        ["topLeft",
         "bottomLeft",
         "bottomRight",
         "topRight"]
    }
    
    static func getPlacesCellData() -> ([String], Int) {
        let album = PhotosDataManager.storage.list.randomElement()
        let mapName = "mapSnapShot"
        let imageName = album?.images.randomElement()?.imageFileName ?? ""
        let placesCount = Int.random(in: 1...(album?.images.count ?? 1))
        return ([mapName, imageName], placesCount)
    }
    
    static func getAlbum(at index: Int) -> PDAlbum? {
        guard index < PhotosDataManager.storage.list.count else {
            return nil
        }
        return PhotosDataManager.storage.list[index]
    }
        
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
