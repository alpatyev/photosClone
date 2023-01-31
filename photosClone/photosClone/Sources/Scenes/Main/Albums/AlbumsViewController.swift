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
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(collection)
    }
    
    private func setupLayout() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(20)
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
                                                              heightDimension: .absolute(defaultPaging * 2.4))
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
                layoutItem.contentInsets.trailing += 2
                
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
                                                              heightDimension: .absolute(defaultPaging * 1.2))
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
                layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                                   leading: 0,
                                                                   bottom: 0,
                                                                   trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalWidth(0.12))
                let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                     subitems: [layoutItem])
                layoutGroup.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                                    leading: 0,
                                                                    bottom: 0,
                                                                    trailing: 0)
                
                let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.orthogonalScrollingBehavior = .none

                layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                                      leading: 0,
                                                                      bottom: 0,
                                                                      trailing: 0)
                
                if section == 2 {
                    let layoutHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                  heightDimension: .absolute(defaultPaging * 1.2))
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPath = collection.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader).first {
            navigationController?.navigationBar.topItem?.title = indexPath.section > 1 ? "Albums" : ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return PhotosDataManager.getAlbumsCount()
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
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: AlbumCell.cellID, for: indexPath) as? AlbumCell {
                    cell.configure(with: PhotosDataManager.getAlbum(at: indexPath.row))
                    return cell
                }
            case 1:
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: OverviewCell.cellID, for: indexPath) as? OverviewCell {
                    if indexPath.row == 0 {
                        cell.configure(type: "People",
                                       images: PhotosDataManager.getPeopleCellData())
                    } else {
                        let (images, count) = PhotosDataManager.getPlacesCellData()
                        cell.configure(type: "Places", images: images, count: count)
                    }
                    return cell
                }
            default:
                if let cell = collection.dequeueReusableCell(withReuseIdentifier: UtilitiesCell.cellID, for: indexPath) as? UtilitiesCell {
                    if let cellModel = PhotosDataManager.createUtilitiesCellModel(for: indexPath.section) {
                        cell.configure(with: cellModel)
                    }
                    cell.accessories = [.disclosureIndicator()]
                    return cell
                }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collection.deselectItem(at: indexPath, animated: true)
        PhotosDataManager.selectedItem(at: indexPath)
    }
}

extension UIView {
    func addBorders(with color: UIColor = .black) {
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.backgroundColor = .clear
    }
}