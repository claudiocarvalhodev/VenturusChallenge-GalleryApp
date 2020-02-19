//
//  HeaderView.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "header-home")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "GALLERY"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "A cat photo gallery app"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.anchor(top: topAnchor, paddingTop: 88, width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        addSubview(descriptionLabel)
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
