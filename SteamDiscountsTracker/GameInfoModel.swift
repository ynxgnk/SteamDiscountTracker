//
//  SteamModel.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import Foundation

struct GameInfo: Codable {
    let gameID: String
    let steamAppID: String
    let title: String
    let retailPrice: String?
    let salePrice: String
    let storeID: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey {
        case gameID
        case steamAppID
        case title
        case retailPrice = "retail_price"
        case salePrice
        case storeID
        case thumb
    }
}
