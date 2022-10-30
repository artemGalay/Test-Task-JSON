//
//  SongsModel.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 30.10.22.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
