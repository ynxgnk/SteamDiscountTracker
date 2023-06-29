//
//  SteamGamesViewModel.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import Foundation

class SteamGamesViewModel {
    let title: String
    let originalPrice: String
    let discountedPrice: String
    let rating: String
    let finalPrice: String
    let image: URL?
    var imageData: Data? = nil
    
    init(title: String, originalPrice: String, discountedPrice: String, rating: String, finalPrice: String, image: URL?) {
        self.title = title
        self.originalPrice = originalPrice
        self.discountedPrice = discountedPrice
        self.rating = rating
        self.finalPrice = finalPrice
        self.image = image
    }
}
