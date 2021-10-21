//
//  NetworkManager.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/13/21.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData(from url: URL, withKey key: String, completion: @escaping ([Store]) -> Void)
    
}

struct StoreManager: NetworkManagerProtocol {
    
    func fetchData(from url: URL, withKey key: String = "store-data", completion: @escaping ([Store]) -> Void) {
        
        if let data = UserDefaults.standard.data(forKey: key) {
            let stores = parseData(data)
            completion(stores)
        } else {
    
    URLSession.shared.dataTask(with: url) {data, response, error in
        guard let data = data else {return}
        completion(parseData(data))
        } .resume()
    }

}
    
    
    private func parseData(_ data: Data) -> [Store] {
        do {
            
            UserDefaults.standard.set(data, forKey: "store-data")
            let parsedData = try JSONDecoder().decode(StoreResult.self, from: data)
            
            return parsedData.stores
            
            }
        catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
}


