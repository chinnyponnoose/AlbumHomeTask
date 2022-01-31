//
//  AlbumListViewController.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 29/01/22.
//

import UIKit

class AlbumListViewController: UIViewController {

    var presenter: ViewToPresenterProtocol?
    var albums: [AlbumModel] = []

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.bringSubviewToFront(activityView)
        activityView.isHidden = false
        activityView.startAnimating()
        presenter?.fetchAllAlbumList()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension AlbumListViewController: PresenterToViewProtocol {

    func showAlbumList(list: [AlbumModel]) {

        albums = list
        tableView.reloadData()
        activityView.stopAnimating()
        activityView.isHidden = true
    }

    func displayError(message: String, displayToast: Bool) {
        if displayToast {
            showToastMessage(message: message, seconds: 2)
        } else {
            showAlert(message: message)
        }
    }

}
extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(album)
        return cell
    }

}
