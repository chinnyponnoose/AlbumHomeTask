//
//  AlbumProtocols.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 29/01/22.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchAllAlbumList()
}

protocol PresenterToViewProtocol: AnyObject {
    func showAlbumList(list: [AlbumModel])
    func displayError(message: String, displayToast: Bool)
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    var dataStore: InteractorToDataStoreProtocol? {get set}
    func fetchAlbumList()
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createAlbumModule() -> AlbumListViewController?
}

protocol InteractorToPresenterProtocol: AnyObject {
    func albumListFetched(list: [AlbumModel])
    func showErrorMessage(message: String, displayToast: Bool)
}

protocol InteractorToDataStoreProtocol: AnyObject {
    func saveAlbums(_ albums: [AlbumModel])
    func retrieveAlbumData() -> [AlbumModel]?

}
