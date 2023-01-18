//
//  UtilitiesCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class UtilitiesCell: UICollectionViewCell {
    
    static var cellID = "utilities"
    
    // MARK: UI
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBorders()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    public func configure() {
        
    }
}
