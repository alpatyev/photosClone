//
//  MyAlbumsHeader.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import SnapKit
import UIKit

final class MyAlbumsHeader: UICollectionReusableView {
    
    static var headerID = "Albums"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
