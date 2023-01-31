//
//  OverviewCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class OverviewCell: UICollectionViewCell, Highlightable {
    
    static var cellID = "overview"
    
    // MARK: - UI
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.title
        return label
    }()
    
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
    
    private lazy var peopleIcons: [UIImageView] = {
        [firstPersonImage,
         secondPersonImage,
         thirdPersonImage,
         fourthPersonImage]
    }()
    
    // MARK: - UI: If places cell type
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.image = UIImage(named: "mapSnapShot")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var smallImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black.withAlphaComponent(0.3)
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray
        label.font = Constants.Fonts.subtitle
        return label
    }()

    // MARK: - Setups if people cell type
    
    private func setupPeopleCell(with images: [String]) {
        if images.count == 4 {
            for (i, name) in images.enumerated() {
                if let exists = UIImage(named: name) {
                    peopleIcons[i].image = exists
                }
            }
        }
        
        itemTitle.text = "People"
        
        setupPeopleCellHierarchy()
        setupPeopleCellLayout()
    }
    
    private func setupPeopleCellHierarchy() {
        peopleIcons.forEach { addSubview($0) }
        addSubview(itemTitle)
    }
    
    private func setupPeopleCellLayout() {
        let width = contentView.frame.width
        let edge = width / 2
        
        peopleIcons.forEach { $0.setupAsIcon(edge: edge) }
        
        firstPersonImage.frame = CGRect(x: 0, y: 0,
                                        width: edge, height: edge)
        secondPersonImage.frame = CGRect(x: 0, y: edge,
                                         width: edge, height: edge)
        thirdPersonImage.frame = CGRect(x: width / 2, y: width / 2,
                                        width: edge, height: edge)
        fourthPersonImage.frame = CGRect(x: width / 2, y: 0,
                                         width: edge, height: edge)
        
        itemTitle.frame = CGRect(x: 0, y: width,
                                 width: width, height: (contentView.frame.height - width) / 2)
    }
    
    // MARK: - Setups if places cell type
    
    private func setupPlacesCell(with images: [String], count: Int) {
        if let map = UIImage(named: images.first ?? "") {
            largeImage.image = map
        }
        if let image = UIImage(named: images[1]) {
            smallImage.image = image
        } else {
            smallImage.image = UIImage(named: "emptyAlbum")
        }
        
        itemsCountTitle.text = "\(count > 0 ? count : 0)"
        itemTitle.text = "Places"
        
        setupPlacesCellHierarchy()
        setupPlacesCellLayout()
    }
    
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
            make.size.equalTo(largeImage).multipliedBy(0.6)
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
    
    public func configure(type: String, images: [String], count: Int = 0) {
        if type == "People" {
            setupPeopleCell(with: images)
        } else if type == "Places" {
            setupPlacesCell(with: images, count: count)
        }
    }
    
    // MARK: - Cell when selected
    
    func highlight() {
        
    }
    
    func unhighlight() {
        
    }
}

// MARK: - ImageView setup

extension UIImageView {
    func setupAsIcon(edge: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = edge / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor;
        self.backgroundColor = .gray.withAlphaComponent(0.2)
    }
}
