//
//  AlbumClient.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import Foundation
import Alamofire

class AlbumClient {
    static let shared = AlbumClient()

    func getAlbumList(from endPoint: String, completion: @escaping (Result<[AlbumModel], NetworkError>) -> Void) {
        let request = AF.request(endPoint)
        request.responseDecodable(of: [AlbumModel].self) { (response) in
            guard let albums = response.value, albums.count > 0  else {
                completion(.failure(.badURL))
                return
            }
            completion(.success(albums))
        }
    }
}
