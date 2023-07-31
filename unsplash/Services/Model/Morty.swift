//
//  Morty.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 30/7/23.
//

import Foundation


struct MortyRes {
    var results: [Morty]
}

struct Morty {
    var id: Int
    var name: String
    var image: String
}
