//
//  AlbumsViewController.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/12/23.
//

import SnapKit
import UIKit

class AlbumsViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var collection: UICollectionView = {
        let layout = createLayout()
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.register(AlbumCell.self,
                            forCellWithReuseIdentifier: AlbumCell.cellID)
        collection.register(OverviewCell.self,
                            forCellWithReuseIdentifier: OverviewCell.cellID)
        collection.register(UtilitiesCell.self,
                            forCellWithReuseIdentifier: UtilitiesCell.cellID)
        collection.delegate = self
        collection.dataSource = self
        return collection
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
        title = "Albums"
    }
    
    private func setupHierarchy() {
        view.addSubview(collection)
    }
    
    private func setupLayout() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.bottom.right.equalTo(view)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection in
            
            let defaultInsets = NSDirectionalEdgeInsets(top: 2,
                                                        leading: 2,
                                                        bottom: 2,
                                                        trailing: 2)
            
            if section == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(0.5))
                
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = defaultInsets
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                       heightDimension: .fractionalWidth(1))
                let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                   subitems: [layoutItem])
                layoutGroup.contentInsets = defaultInsets
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = defaultInsets
                
                return layoutSection
            } else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalWidth(0.5))
                
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = defaultInsets
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.5))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])
                layoutGroup.contentInsets = defaultInsets
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = defaultInsets
                
                return layoutSection
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                                   leading: 2,
                                                                   bottom: 2,
                                                                   trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.12))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])
                layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 1,
                                                                    leading: 1,
                                                                    bottom: 1,
                                                                    trailing: 1)
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .none

                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                                      leading: 2,
                                                                      bottom: 2,
                                                                      trailing: 2)
                
                return layoutSection
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumsViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
}

// MARK: - UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
            case 0:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: AlbumCell.cellID, for: indexPath)
                return cell
            case 1:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: OverviewCell.cellID, for: indexPath)
                return cell
            default:
                let cell = collection.dequeueReusableCell(withReuseIdentifier: UtilitiesCell.cellID, for: indexPath)
                return cell
        }
    }
}
