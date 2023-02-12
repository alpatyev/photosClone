//
//  DetailViewController.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 2/11/23.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(centerLabel)
    }
    
    private func setupLayout() {
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(view.snp.width).dividedBy(4)
        }
    }
    
    // MARK: - Configuration
    
    func setupLabel(with text: String) {
        centerLabel.text = text
    }
}
