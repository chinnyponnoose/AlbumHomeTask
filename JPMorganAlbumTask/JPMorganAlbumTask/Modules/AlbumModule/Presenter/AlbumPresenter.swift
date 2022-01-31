//
//  AlbumPresenter.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import Foundation

class AlbumPresenter: ViewToPresenterProtocol {

    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?

    func fetchAllAlbumList() {
        interactor?.fetchAlbumList()
    }

}

extension AlbumPresenter: InteractorToPresenterProtocol {

    func albumListFetched(list: [AlbumModel]) {
        view?.showAlbumList(list: list)
    }

    func showErrorMessage(message: String, displayToast: Bool) {
        view?.displayError(message: message, displayToast: displayToast)

    }

}
