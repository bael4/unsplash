//
//  UnsplashModel.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import Foundation


struct Unsplash: Codable {
    var id: String
    var urls: Urls
    var alt_description: String
}

struct Urls:Codable {
    var full: String
}
