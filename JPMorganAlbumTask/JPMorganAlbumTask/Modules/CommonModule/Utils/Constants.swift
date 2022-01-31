//
//  Constants.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import Foundation

public enum NetworkError: Error {
    case badURL
}

enum Constants {
    static let albumListApi = "https://jsonplaceholder.typicode.com/albums"
    static let offlineDataKey = "offlineKey"
    static let offlineToastMessage = "You are viewing offline data"
    static let networkErrorMessage = "Network error, Please try after some time"
}
