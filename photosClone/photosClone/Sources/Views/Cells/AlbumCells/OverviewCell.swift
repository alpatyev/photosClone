//
//  OverviewCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class OverviewCell: UICollectionViewCell {
    
    static var cellID = "overview"
    
    // MARK: - UI: If people cell type
    
    private lazy var firstPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var secondPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var thirdPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var fourthPersonImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        return label
    }()
    
    // MARK: - UI: If places cell type
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var smallImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    // MARK: - Setups if people cell type
    
    private func setupPeopleCellHierarchy() {
        addSubview(firstPersonImage)
        addSubview(secondPersonImage)
        addSubview(thirdPersonImage)
        addSubview(fourthPersonImage)
        addSubview(itemTitle)
    }
    
    private func setupPeopleCellLayout() {
        let width = contentView.frame.width
        let edge = width / 2
        let icons = [firstPersonImage,
                     secondPersonImage,
                     thirdPersonImage,
                     fourthPersonImage]
        
        icons.forEach { $0.layer.cornerRadius = edge / 2 }
        
        firstPersonImage.frame = CGRect(x: 0,
                                        y: 0,
                                        width: edge,
                                        height: edge)
        secondPersonImage.frame = CGRect(x: 0,
                                         y: edge,
                                         width: edge,
                                         height: edge)
        thirdPersonImage.frame = CGRect(x: width / 2,
                                        y: width / 2,
                                        width: edge,
                                        height: edge)
        
        fourthPersonImage.frame = CGRect(x: width / 2,
                                         y: 0,
                                         width: edge,
                                         height: edge)
        
        itemTitle.frame = CGRect(x: 0,
                                 y: width,
                                 width: width,
                                 height: (contentView.frame.height - width) / 2)
        
        firstPersonImage.addBorders()
        secondPersonImage.addBorders()
        thirdPersonImage.addBorders()
        fourthPersonImage.addBorders()
    }
    
    // MARK: - Setups if places cell type
    
    private func setupPlacesCellHierarchy() {
        addSubview(largeImage)
        addSubview(smallImage)
        addSubview(itemTitle)
        addSubview(itemsCountTitle)
    }
    
    private func setupPlacesCellLayout() {
        largeImage.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        smallImage.snp.makeConstraints { make in
            make.center.equalTo(largeImage)
            make.size.equalTo(largeImage).dividedBy(2)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.top.equalTo(largeImage.snp.bottom)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(itemsCountTitle.snp.top)
        }
        
        itemsCountTitle.snp.makeConstraints { make in
            make.height.equalTo(itemTitle)
            make.width.centerX.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configure cell with recieved data
    
    public func configure(as type: String) {
        if type == "People" {
            setupPeopleCellHierarchy()
            setupPeopleCellLayout()
        } else if type == "Places" {
            setupPlacesCellHierarchy()
            setupPlacesCellLayout()
        }
        addBorders()
        largeImage.addBorders()
        smallImage.addBorders()
        itemTitle.addBorders()
        itemsCountTitle.addBorders()
    }
}
