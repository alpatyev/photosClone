//
//  PeopleAndPlacesHeader.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/18/23.
//

import UIKit

final class PeopleAndPlacesHeader: UICollectionReusableView {
    
    static let headerID = "People & Places"
    
    // MARK: - UI
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = PeopleAndPlacesHeader.headerID
        label.font = Constants.Fonts.subHeaderFont
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var divider: UIView = {
        let line = UIView()
        line.backgroundColor = .gray.withAlphaComponent(0.5)
        return line
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
        addSubview(divider)
        addSubview(topTitle)
    }
    
    private func setupLayout() {
        divider.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
        topTitle.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(divider.snp.bottom)
        }
    }
}
