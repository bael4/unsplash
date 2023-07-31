//
//  FavouriteViewModel.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 31/7/23.
//

import Foundation

class FavouriteViewModel {
    
    private let defaults = UserDefaults.standard
    
    private var favouriteImages: [Unsplash] = []

    func getFavouriteImages() -> [Unsplash] {
        if let favourites = defaults.object(forKey: "saved") as? Data  {
            let savedFavourites = try? JSONDecoder().decode([Unsplash].self, from: favourites)
            guard let savedFavourites = savedFavourites else {return []}
            favouriteImages = savedFavourites
        }
        return favouriteImages
    }
}

