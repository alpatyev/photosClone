//
//  Constants.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/30/23.
//

import UIKit

enum Constants {
    enum Colors {
        static var background = UIColor.white
        static var primary = UIColor(red: 0.09, green: 0.01, blue: 0.25, alpha: 1.00)
        static var border = UIColor.black
        static var text = UIColor.black
        static var lightText = UIColor.white
        static var highlighted = UIColor.black.withAlphaComponent(0.5)
        static var divider = UIColor.gray.withAlphaComponent(0.25)
    }
    
    enum Fonts {
        static var headerFont = UIFont.systemFont(ofSize: 36, weight: .bold)
        static var subHeaderFont = UIFont.systemFont(ofSize: 22, weight: .bold)
        static var title = UIFont.systemFont(ofSize: 16, weight: .regular)
        static var subtitle = UIFont.systemFont(ofSize: 16, weight: .medium)
        static var utilitilesTitile = UIFont.systemFont(ofSize: 20, weight: .regular)
    }
    
    enum Layout {
        static var paging: CGFloat = 36
        static var cornerRadius: CGFloat = 8
        static var borderWidth: CGFloat = 1.25
    }
}
