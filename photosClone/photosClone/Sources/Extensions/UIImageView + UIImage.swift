//
//  UIImageView + UIImage.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 2/1/23.
//

import UIKit

// MARK: - Setups image for normal and tinted image for highlighted state

extension UIImageView {
    func setupImageForBothStates(image named: String, border color: UIColor? = nil) {
        guard let image = UIImage(named: named) else {
            return
        }
        self.image = image
        self.highlightedImage = image.imageWithTintColor(color: Constants.Colors.highlighted)
    }
}

extension UIImage {
    func imageWithTintColor(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return nil
        }
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -size.height)
        
        let rect = CGRect(origin: .zero, size: size)
        context.draw(cgImage, in: rect)
        color.setFill()
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: - Setups imageView as an icon

extension UIImageView {
    func setupAsIcon(edge: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = edge / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor;
        self.backgroundColor = .gray.withAlphaComponent(0.2)
    }
}
