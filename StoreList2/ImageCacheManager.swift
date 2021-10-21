//
//  ImageCacheManager.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/15/21.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    static func getImage(from url: String, completion: @escaping (UIImage?) -> Void)
    
}

struct ImageCacheManager: ImageCacheProtocol {
    static func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        if let imageData = UserDefaults.standard.data(forKey: url) {
            completion(UIImage(data: imageData))
        } else {
            guard let url = URL(string: url) else {
                print("Wrong url")
                completion(nil)
                return
            }
            URLSession.shared.dataTask(with: url) {data, response, eror in
                guard let data = data else {return}
                completion(UIImage(data: data))
            }.resume()
        }
    }
}
