//
//  NetworkRequest.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 29.10.22.
//

import Foundation

class NetworkRequest {

    static let shared = NetworkRequest()

    private init() {}

    func requestData(urlString: String, complition: @escaping (Result<Data, Error>) -> ()) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    complition(.failure(error))
                    return
                }

                guard let data = data else { return }
                complition(.success(data))
            }
        }.resume()
    }
}
