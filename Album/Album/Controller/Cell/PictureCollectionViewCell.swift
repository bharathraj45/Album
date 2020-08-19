//
//  PictureCollectionViewCell.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    func populate(userAlbum: UserAlbum) {
        if let urlString = userAlbum.thumbnailUrl {
            pictureImageView.setup(with: urlString, placeholderImage: nil)
        }
    }
}
