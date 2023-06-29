//
//  APICaller.swift
//  SteamDiscountsTracker
//
//  Created by Nazar Kopeika on 28.06.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let API_URL = URL(string: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=5")
//    "https://www.cheapshark.com/api/1.0/deals?id=X8sebHhbc1Ga0dTkgg59WgyM506af9oNZZJLU9uSrX8%3D"
    }
    
    private init() {}
    
    public var info: [GameInfo] = []
    
    public func getSteamData(completion: @escaping (Result<[GameInfo], Error>) -> Void) {
        guard let url = Constants.API_URL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode([GameInfo].self, from: data)
                    completion(.success(result))
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                    print(result)
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
