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
    
    static let screenSize = UIScreen.main.bounds
    
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
        collection.register(MyAlbumsHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MyAlbumsHeader.headerID)
        collection.register(PeopleAndPlacesHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: PeopleAndPlacesHeader.headerID)
        collection.register(UtilitiesHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: UtilitiesHeader.headerID)
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
            let defaultPaging = AlbumsViewController.screenSize.width * 0.1
            
            if section == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(0.5))
                
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = defaultInsets
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                       heightDimension: .fractionalWidth(1.2))
                let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                                   subitems: [layoutItem])
                layoutGroup.contentInsets = defaultInsets
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = defaultInsets
                layoutSection.contentInsets.bottom = defaultPaging / 2
                
                let layoutHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .estimated(defaultPaging * 2.1))
                let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: layoutHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                layoutSection.boundarySupplementaryItems = [layoutHeader]
                
                return layoutSection
            } else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                      heightDimension: .fractionalHeight(1))
                
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                layoutItem.contentInsets = defaultInsets
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.6))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])
                layoutGroup.contentInsets = defaultInsets
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .groupPaging
                layoutSection.contentInsets = defaultInsets
                layoutSection.contentInsets.bottom = defaultPaging / 2
                
                let layoutHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                              heightDimension: .estimated(defaultPaging))
                let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: layoutHeaderSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                layoutSection.boundarySupplementaryItems = [layoutHeader]
                
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
                
                if section == 2 {
                    let layoutHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                  heightDimension: .estimated(defaultPaging))
                    let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: layoutHeaderSize,
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top)
                    layoutSection.boundarySupplementaryItems = [layoutHeader]
                }
                
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
            return 2
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
            case 0:
                let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyAlbumsHeader.headerID, for: indexPath)
                return header
            case 1:
                let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PeopleAndPlacesHeader.headerID, for: indexPath)
                return header
            default:
                let header = collection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UtilitiesHeader.headerID, for: indexPath)
                return header
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


extension UIView {
    func addBorders(with color: UIColor = .black) {
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.backgroundColor = .clear
    }
}
