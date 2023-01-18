//
//  PeopleAndPlacesHeader.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class PeopleAndPlacesHeader: UICollectionReusableView {
    
    static let headerID = "People & Places"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addBorders()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
