//
//  UtilitiesHeader.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

class UtilitiesHeader: UICollectionReusableView {
    static var headerID = "Utilities"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        addBorders()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
