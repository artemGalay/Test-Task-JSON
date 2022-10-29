//
//  AlbumModel.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 29.10.22.
//

import Foundation

struct AlbumModel: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
    let releaseDate: String
}
