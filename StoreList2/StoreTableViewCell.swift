//
//  StoreTableViewCell.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/12/21.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
   static let identifier = "Cell"
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        
    }
    
    func setupWithData(_ storeData: Store) {
        titleLabel.text = storeData.name
        ImageCacheManager.getImage(from: storeData.storeLogoURL) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.logoImageView.image = image
                }
                
            }
            
            
            
        }
        
        
    }
    

    }

