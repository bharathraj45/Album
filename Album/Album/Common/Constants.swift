//
//  Constants.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation

struct Constants {
    
    struct SegueIdentifiers {
        static let homeToPictureView = "ViewPictures"
    }
    
    struct Cell {
        static let albumTitleTableViewCell = "AlbumTitleTableViewCell"
        static let pictureCollectionViewCell = "PictureCollectionViewCell"
    }
    
    struct NavigationBarTitle {
        static let albums = "Albums"
        static let album = "Album"
    }
    
    struct Alert {
        static let infoText = "Info"
        static let message = "Looks like there are isn't data to display"
        static let errorText = "Something went wrong"
    }
}
