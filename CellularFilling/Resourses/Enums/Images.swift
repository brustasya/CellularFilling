//
//  Images.swift
//  CellularFilling
//
//  Created by Станислава on 18.07.2024.
//

import UIKit

enum Images: String {
    case life = "life"
    case living = "living"
    case dead = "dead"
    
    var uiImage: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
