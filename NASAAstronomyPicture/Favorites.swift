//
//  Favorites.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 22/07/22.
//

import Foundation

class Favorites: ObservableObject {
    
    // the actual pictures the user has favorited
    @Published var pictures: [PictureOfDay] = []
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        
        // assign the existing array
        pictures = self.getPictureFromUserDefaults()
    }
    
    /// returns true if the array contains this picture
    func contains(_ picture: PictureOfDay) -> Bool {
        pictures.contains(picture)
    }
    
    /// returns sorted array by date
    func sortedByDate(_ pictures: [PictureOfDay]) -> [PictureOfDay] {
        return pictures.sorted(by: { if let date1 = $0.date, let date2 = $1.date { return date1 > date2 }
            return false })
    }
    
    /// adds the picture to the array, updates all views, and saves the change
    func add(_ picture: PictureOfDay) {
        objectWillChange.send()
        pictures.append(picture)
        setPictureInUserDefaults(pictures: pictures)
    }
    
    /// removes the picture from the array, updates all views, and saves the change
    func remove(_ picture: PictureOfDay) {
        objectWillChange.send()
        guard let index = pictures.firstIndex(where: { $0.url == picture.url }) else {return}
        pictures.remove(at: index)
        setPictureInUserDefaults(pictures: pictures)
    }
    
    /// removes all the pictures from the array, updates all views, and saves the change
    func removeAll() {
        objectWillChange.send()
        pictures.removeAll()
        setPictureInUserDefaults(pictures: pictures)
    }
    
    ///set to UserDefaults
    func setPictureInUserDefaults(pictures: [PictureOfDay]) {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Note
            let data = try encoder.encode(pictures)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: saveKey)
            
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    ///get from UserDefaults
    func getPictureFromUserDefaults() -> [PictureOfDay] {
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let pictures = try decoder.decode([PictureOfDay].self, from: data)
                return pictures
                
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
            
        }
        return []
    }
}
