//
//  UtilitiesCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class UtilitiesCell: UICollectionViewCell {
    static var cellID = "utilities"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.addBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
