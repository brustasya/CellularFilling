//
//  CellsCreationPresenter.swift
//  CellularFilling
//
//  Created by Станислава on 18.07.2024.
//

import Foundation

final class CellsCreationPresenter {
    weak var viewInput: CellsCreationViewInput?
    
    private lazy var cells: [CellModel] = []
    
    private func createCell() {
        let newCell = Bool.random() ? CellModel(type: .living) : CellModel(type: .dead)
        cells.append(newCell)
        viewInput?.applySnapshot(cells: cells)
        
        guard cells.count >= 3 else { return }
        if newCell.type == .living {
            if cells[cells.count - 2].type == .living && cells[cells.count - 3].type == .living {
                cells.append(CellModel(type: .life))
                viewInput?.applySnapshot(cells: cells)
            }
        } else if newCell.type == .dead {
            if cells.count > 3 &&
               cells[cells.count - 2].type == .dead &&
               cells[cells.count - 3].type == .dead &&
               cells[cells.count - 4].type == .life
            {
                cells.remove(at: cells.count - 4)
                viewInput?.applySnapshot(cells: cells)
            }
        }
    }
}

extension CellsCreationPresenter: CellsCreationViewOutput {
    func createButtonTapped() {
        createCell()
    }
}
