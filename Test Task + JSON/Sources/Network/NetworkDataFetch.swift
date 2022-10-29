//
//  NetworkDataFetch.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 29.10.22.
//

import Foundation

class NetworkDataFetch {

    static let shared = NetworkDataFetch()

    private init() {}

    func fetchAlbum(urlString: String, responce: @escaping (AlbumModel?, Error?) -> ()) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in

            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    responce(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received reuesting data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
