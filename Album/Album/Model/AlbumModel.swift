//
//  AlbumModel.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
}

struct UserAlbum: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String?
    let thumbnailUrl: String?
}
