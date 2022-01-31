//
//  AppDelegate.swift
//  JPMorganAlbumTask
//
//  Created by Chinny Ponnoose on 31/01/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        guard let album = AlbumRouter.createAlbumModule() else {
            return true
        }
        navigationController.viewControllers = [album]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
