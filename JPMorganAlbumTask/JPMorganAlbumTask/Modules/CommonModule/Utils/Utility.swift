//
//  Utility.swift
//  JPMorganAlbumTask
//
//  Created by Chinny Ponnoose on 31/01/22.
//

import Foundation
import UIKit

extension UIStoryboard {

  public static var main: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
}

extension UIViewController {

    func showToastMessage(message: String, seconds: Double) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

    func  showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

class Utility {

    static var filePath: String? {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return (url.appendingPathComponent("Album").path)
    }
}
