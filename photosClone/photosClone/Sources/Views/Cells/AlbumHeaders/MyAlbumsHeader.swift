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
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var divider: UIView = {
        let line = UIView()
        line.backgroundColor = .gray.withAlphaComponent(0.8)
        return line
    }()
    
    private lazy var bottomTitle: UILabel = {
        let label = UILabel()
        label.text = "My \(MyAlbumsHeader.headerID)"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBorders()
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
    }
    
    private func setupLayout() {
        topTitle.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(divider.snp.top)
        }
        
        divider.snp.makeConstraints { make in
            make.left.right.centerY.equalToSuperview()
            make.height.equalTo(2)
        }
        
        bottomTitle.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(divider.snp.bottom)
        }
    }
}
