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
    
    // MARK: - UI
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = MyAlbumsHeader.headerID
        label.font = Constants.Fonts.headerFont
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var divider: UIView = {
        let line = UIView()
        line.backgroundColor = .gray.withAlphaComponent(0.5)
        return line
    }()
    
    private lazy var bottomTitle: UILabel = {
        let label = UILabel()
        label.text = "My \(MyAlbumsHeader.headerID)"
        label.font = Constants.Fonts.subHeaderFont
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemBlue.withAlphaComponent(0.5), for: .highlighted)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        return button
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
        addSubview(topTitle)
        addSubview(divider)
        addSubview(bottomTitle)
        addSubview(seeAllButton)
    }
    
    private func setupLayout() {
        topTitle.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(divider.snp.top)
        }
        
        divider.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bottomTitle.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(divider.snp.bottom)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.height.centerY.equalTo(bottomTitle)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(56)
        }
    }
    
    // MARK: - Action
    
    @objc private func tapped() {
        print("<See all> tapped")
    }
}
