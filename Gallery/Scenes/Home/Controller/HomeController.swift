//
//  HomeController.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import UIKit
//import SnapKit
import SDWebImage

private let headerIdentifier = "HeaderView"
private let cellIdentifier = "GalleryCell"

class HomeController: UICollectionViewController {

    // MARK: - Properties
    
    private var urls = [String]()
    private var type = "image/jpeg"
    private var listViewModel: ImgurListViewModel?
    let margin: CGFloat = 16
    let idealCellWidth: CGFloat = 100
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        self.listViewModel = ImgurListViewModel(delegate: self)
        self.listViewModel?.loadList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Methods
    
    func setElements() {
        collectionView.backgroundColor = .white
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .always
    
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate/DataSource

extension HomeController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HeaderView
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let url = URL(string: urls[indexPath.row])!
            SDWebImagePrefetcher.shared.prefetchURLs([url], progress: nil) { (finishedCount, skippedCount) in
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? GalleryCell else {
            return UICollectionViewCell()
        }
        if let url = urls[indexPath.row] as String? {
            cell.updateCell(url: url)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            let width = (view.frame.width - 52 - 100) / 3
            return CGSize(width: width, height: width)
        }
        else {
            let width = (view.frame.width - 52) / 3
            return CGSize(width: width, height: width)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

extension HomeController: ImgurListProtocol {
    func didLoadList(list: ImgurModelData) {
        _ = list.data?.filter({ (_models) -> Bool in
            let images = _models.images?.filter({ (images) -> Bool in
                if images.type == type {
                    return true
                }
                return false
            }).compactMap{ $0 }
            let links = images?.compactMap{ $0.link }
            _ = links?.filter({ (url) -> Bool in
                urls.append(url)
                return true
            })
            return true
        })
        self.collectionView.reloadData()
    }
    
    func didFailed() {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 0
        }
    }
}
