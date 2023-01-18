//
//  AlbumCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    static var cellID = "album"
    
    // MARK: - UI
    
    private lazy var largeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        return label
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBorders()
        setupHierarchy()
        setupLayout()
        
        largeImage.addBorders()
        itemTitle.addBorders()
        itemsCountTitle.addBorders()
        
        largeImage.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(largeImage)
        addSubview(itemTitle)
        addSubview(itemsCountTitle)
    }
    
    private func setupLayout() {
        largeImage.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width)
            make.top.centerX.equalToSuperview()
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
    
    public func configure() {
        
    }
}
