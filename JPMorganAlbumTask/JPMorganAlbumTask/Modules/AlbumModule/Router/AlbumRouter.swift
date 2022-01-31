//
//  AlbumRouter.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import Foundation
import UIKit

class AlbumRouter: PresenterToRouterProtocol {

    static func createAlbumModule() -> AlbumListViewController? {

        guard let view = UIStoryboard.main.instantiateViewController(withIdentifier:
                                        "AlbumViewController") as? AlbumListViewController else {
            return nil
        }
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = AlbumPresenter()
        let interactor: PresenterToInteractorProtocol = AlbumInteractor()
        let router: PresenterToRouterProtocol = AlbumRouter()
        let datastore: InteractorToDataStoreProtocol = AlbumOfflineStorage()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.dataStore = datastore
        return view

    }

}
