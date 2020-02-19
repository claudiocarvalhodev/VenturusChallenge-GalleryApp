//
//  GalleryCell.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class GalleryCell: UICollectionViewCell {
    
    // MARK: - Properties

    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            cellImageView.image = image
        }
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cellImageView)
        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func updateCell(url: String) {
        let url = URL(string: url)
        cellImageView.kf.indicatorType = .activity
        cellImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
