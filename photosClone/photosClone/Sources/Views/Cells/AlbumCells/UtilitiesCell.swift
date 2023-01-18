//
//  UtilitiesCell.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class UtilitiesCell: UICollectionViewCell {
    
    static var cellID = "utilities"
    
    // MARK: UI
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        return label
    }()
    
    private lazy var itemsCountTitle: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var disclosureIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosure.indicator")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        addSubview(icon)
        addSubview(titleLabel)
        addSubview(itemsCountTitle)
        addSubview(disclosureIndicator)
    }
    
    private func setupLayout() {
        icon.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(contentView.snp.height)
            make.left.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right)
            make.top.bottom.right.equalToSuperview()
        }
        
        disclosureIndicator.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.3)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(contentView.frame.height * 0.4)
        }
        
        itemsCountTitle.snp.makeConstraints { make in
            make.height.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.height)
            make.right.equalTo(disclosureIndicator.snp.left)
        }
    
        icon.addBorders()
        titleLabel.addBorders()
        itemsCountTitle.addBorders()
        disclosureIndicator.addBorders()
        
        icon.backgroundColor = .black.withAlphaComponent(0.5)
        titleLabel.backgroundColor = .green.withAlphaComponent(0.5)
        itemsCountTitle.backgroundColor = .blue.withAlphaComponent(0.2)
        disclosureIndicator.backgroundColor = .red.withAlphaComponent(0.5)
        
    }
    
    public func configure() {
        
        // TODO: - ADD DIVIDER SUBVIEW !!!
        
        addBorders()
        setupHierarchy()
        setupLayout()
    }
}
