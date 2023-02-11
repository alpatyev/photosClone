//
//  AlbumsViewController.swift
//  photosClone
//
//  Created by Nikita Alpatiev on 1/12/23.
//

import SnapKit
import UIKit

// MARK: - Protocol that provides highlight ability

protocol Highlightable: AnyObject {
    func highlight()
    func unhighlight()
}

class AlbumsViewController: UIViewController {
    
    // MARK: - UI
    
    static let screenSize = UIScreen.main.bounds
  
    private lazy var collection: UICollectionView = {
        let layout = createCollectionLayout()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = nil
    }
    
    // MARK: - Setup collection and navigation bar
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItems = createBarItems()
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
    
    private func createCollectionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [unowned self] (section, environement) -> NSCollectionLayoutSection in
            switch section {
                case 0:
                    return self.createAlbumsLayout()
                case 1:
                    return self.createPeopleAndPlacesLayout()
                case 2:
                    return self.createUtilitiesLayoutWithHeader(with: environement)
                default:
                    return self.createUtilitiesLayout(with: environement)
            }
        }
    }
    
    private func createAlbumsLayout() -> NSCollectionLayoutSection {
        let defaultInsets = NSDirectionalEdgeInsets(top: 2,
                                                    leading: 2,
                                                    bottom: 2,
                                                    trailing: 2)
        let defaultPaging = AlbumsViewController.screenSize.width * 0.1
        
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
        layoutSection.orthogonalScrollingBehavior = .paging
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
    }
    
    private func createPeopleAndPlacesLayout() -> NSCollectionLayoutSection {
        let defaultInsets = NSDirectionalEdgeInsets(top: 2,
                                                    leading: 2,
                                                    bottom: 2,
                                                    trailing: 2)
        let defaultPaging = AlbumsViewController.screenSize.width * 0.1
        
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
        layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
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
    }
    
    private func createUtilitiesLayout(with environement: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        
        let layoutSection = NSCollectionLayoutSection.list(using: configuration,
                                                           layoutEnvironment: environement)
        
        return layoutSection
    }
    
    private func createUtilitiesLayoutWithHeader(with environement: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let defaultPaging = AlbumsViewController.screenSize.width * 0.1
        
        //
        
        let layoutSection = createUtilitiesLayout(with: environement)
        
        let layoutHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(defaultPaging * 1.2))
        let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        layoutSection.boundarySupplementaryItems = [layoutHeader]
        
        return layoutSection
    }
    

    
    
    // MARK: - Setup left navigation bar item
    
    private func createBarItems() -> [UIBarButtonItem] {
        [UIBarButtonItem(title: nil,
                         image: UIImage(named: "plus"),
                         primaryAction: nil,
                         menu: createBarMenu())]
    }
    
    private func createBarMenu() -> UIMenu {
        let first = UIAction(title: "New Album", image: UIImage(systemName: "rectangle.stack.badge.plus")) { _ in
            PhotosDataManager.createAlbumTapped()
        }
        
        let second = UIAction(title: "New Folder", image: UIImage(systemName: "folder.badge.plus")) { _ in
            PhotosDataManager.createFolderTapped()
        }
        
        return UIMenu(title: "", children: [first, second])
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPath = collection.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionView.elementKindSectionHeader).first {
            navigationController?.navigationBar.topItem?.title = indexPath.section > 1 ? "Albums" : nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PhotosDataManager.getNumberOfItems(for: section)
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
                    return cell
                }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collection.deselectItem(at: indexPath, animated: true)
        let someData = PhotosDataManager.selectedItem(at: indexPath)
        let controller = DetailViewController()
        controller.setupLabel(with: someData)
        navigationController?.navigationBar.topItem?.title = "Albums"
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collection.cellForItem(at: indexPath) as? Highlightable {
            cell.highlight()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collection.cellForItem(at: indexPath) as? Highlightable {
            cell.unhighlight()
        }
    }
}
