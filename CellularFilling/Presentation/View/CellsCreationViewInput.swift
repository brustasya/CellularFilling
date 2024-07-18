//
//  CellsCreationViewInput.swift
//  CellularFilling
//
//  Created by Станислава on 18.07.2024.
//

import Foundation

protocol CellsCreationViewInput: AnyObject {
    func applySnapshot(cells: [CellModel])
}
