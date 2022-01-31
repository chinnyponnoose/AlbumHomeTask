//
//  AlbumPresenterTests.swift
//  JPMorganAlbumTaskTests
//
//  Created by Chinny Ponnoose on 31/01/22.
//

import XCTest
@testable import JPMorganAlbumTask

class AlbumPresenterTests: XCTestCase {

    var presenter: AlbumPresenter!
    var view = AlbumMockView()
    var interactor = AlbumInteractorMock()

    override func setUp() {
        presenter = AlbumPresenter()
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    func testFetchAlbumData() {
        presenter.fetchAllAlbumList()
        XCTAssertEqual(view.albumAdded,
                       true)
    }

    func testErrorMessages() {
        presenter.showErrorMessage(message: "Network Error", displayToast: false)
        XCTAssertEqual(view.shouldShowError,
                       true)
    }

    override func tearDown() {
        presenter = nil
    }

}

class AlbumMockView: PresenterToViewProtocol {

    var shouldShowError = false
    var albumAdded = false

    func showAlbumList(list: [AlbumModel]) {
        if list.count == 1 {
            albumAdded = true
        }
    }

    func displayError(message: String, displayToast: Bool) {
       shouldShowError = true
    }
}
class AlbumInteractorMock: PresenterToInteractorProtocol {

    var presenter: InteractorToPresenterProtocol?
    var dataStore: InteractorToDataStoreProtocol?

    func fetchAlbumList() {
        let album = AlbumModel(id: 1, userId: 1, title: "Test Title")
        presenter?.albumListFetched(list: [album])
    }

}
