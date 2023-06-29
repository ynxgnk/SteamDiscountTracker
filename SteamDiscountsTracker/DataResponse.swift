//
//  DataResponse.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import Foundation

struct SteamDataResponse: Codable {
    let games: [GameInfo]
}


