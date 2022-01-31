//
//  AlbumInteractor.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 30/01/22.
//

import Foundation

class AlbumInteractor: PresenterToInteractorProtocol {

    var dataStore: InteractorToDataStoreProtocol?
    var presenter: InteractorToPresenterProtocol?

    private let client: AlbumClient

    init(client: AlbumClient = AlbumClient.shared) {
        self.client = client
    }

    func fetchAlbumList() {

        client.getAlbumList(from: Constants.albumListApi) { [weak self] (result) in
            switch result {
            case .success(let albums):
                let sortedAlbums = albums.sorted(by: {$0.title < $1.title})
                self?.dataStore?.saveAlbums(sortedAlbums)
                self?.presenter?.albumListFetched(list: sortedAlbums)
            case .failure(let error):
                print(error.localizedDescription)
                guard let albums = self?.dataStore?.retrieveAlbumData(), albums.count > 0 else {
                    self?.presenter?.showErrorMessage(message: Constants.networkErrorMessage, displayToast: false)
                    return
                }
                self?.presenter?.showErrorMessage(message: Constants.offlineToastMessage, displayToast: true)
                self?.presenter?.albumListFetched(list: albums)
            }
        }
    }

}
