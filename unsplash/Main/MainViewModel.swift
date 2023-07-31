//
//  MainModel.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import Foundation

protocol MainViewModelLogic: AnyObject {
    func saveFavouriteImages(id: String)
    func getImages(completion: @escaping ([Unsplash]) -> Void)
}

class MainViewModel: MainViewModelLogic {
    
    private var images: [Unsplash] = []
    
    private let defaults = UserDefaults.standard
    
    private var imagesToSave: [Unsplash] = []
    
    func getImages(completion: @escaping ([Unsplash]) -> Void) {

        let queue = DispatchQueue(label: "gggg")
        
        queue.async {
            NetworkManager.networkManager.getImages(APIConfig.unsplashBaseURL, type: Unsplash.self) { success, result in
                DispatchQueue.main.async {
                    if success {
                        self.images = result
                        completion(self.images)
                    } else {
                        completion([])
                    }
                }
                
            }
        }
        
    }
    
    func saveFavouriteImages(id: String) {
        let imageToSave = images.filter {$0.id == id }
        
        getPreviosFavourites()
        
        if !imagesToSave.contains(where: {$0.id == id}) {
            imagesToSave.append(contentsOf: imageToSave)
            
            if let encodedData = try? JSONEncoder().encode(imagesToSave) {
                defaults.set(encodedData, forKey: "saved")
            }
        }
    }
    
    private func getPreviosFavourites() {
        if let favouritesImages = defaults.object(forKey: "saved") as? Data  {
            if let savedFavourites = try? JSONDecoder().decode([Unsplash].self, from: favouritesImages) {
                imagesToSave = savedFavourites
            }
        }
    }
}
