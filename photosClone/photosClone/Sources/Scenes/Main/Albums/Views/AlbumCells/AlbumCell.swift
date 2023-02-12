//
//  AlbumCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class AlbumCell: UICollectionViewCell, Highlightable {
    
    static var cellID = "album"
    
    // MARK: - UI
    
    private lazy var container: UIView = {
        let subview = UIView()
        return subview
    }()
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageForBothStates(image: "emptyAlbum")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.text = "Album"
        label.font = Constants.Fonts.title
        return label
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray
        label.font = Constants.Fonts.subtitle
        return label
    }()
    
    private lazy var likeSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "likeSymbol")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(container)
        container.addSubview(largeImage)
        container.addSubview(itemTitle)
        container.addSubview(itemsCountTitle)
    }
    
    private func setupLayout() {
        container.snp.makeConstraints { make in
            make.size.equalToSuperview().multipliedBy(1)
            make.center.equalToSuperview()
        }
                
        largeImage.snp.makeConstraints { make in
            make.width.height.equalTo(container.snp.width)
            make.top.centerX.equalTo(container)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.top.equalTo(largeImage.snp.bottom)
            make.width.centerX.equalTo(container)
            make.bottom.equalTo(itemsCountTitle.snp.top)
        }
        
        itemsCountTitle.snp.makeConstraints { make in
            make.height.equalTo(itemTitle)
            make.width.centerX.bottom.equalTo(container)
        }
    }
    
    private func addLikeSymbol() {
        largeImage.addSubview(likeSymbol)
        
        likeSymbol.snp.makeConstraints { make in
            make.width.height.equalToSuperview().dividedBy(12)
            make.left.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().inset(6)
        }
    }
    
    // MARK: - Configure with data
    
    public func configure(with data: PDAlbum?) {
        guard let model = data else {
            return
        }
        if model.name == "Favorites" {
            addLikeSymbol()
        }
        itemTitle.text = model.name
        
        guard let last = model.images.last else {
            return
        }
        largeImage.setupImageForBothStates(image: last.imageFileName)
        itemsCountTitle.text = "\(model.images.count)"
    }
    
    // MARK: - Cell when selected
    
    func highlight() {
        largeImage.isHighlighted = true
    }
    
    func unhighlight() {
        largeImage.isHighlighted = false
    }
}

