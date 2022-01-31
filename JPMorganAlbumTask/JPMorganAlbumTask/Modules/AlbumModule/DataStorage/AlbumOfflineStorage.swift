//
//  AlbumOfflineStorage.swift
//  JPMorganAlbumTask
//
//  Created by Chinny Ponnoose on 31/01/22.
//

import Foundation

class AlbumOfflineStorage: InteractorToDataStoreProtocol {

    func saveAlbums(_ albums: [AlbumModel]) {

        guard let data = try? NSKeyedArchiver.archivedData(withRootObject:
                                                            albums, requiringSecureCoding: false) else { return }
        do {

            guard let filepath = Utility.filePath else {
                return
            }
            let path = URL(fileURLWithPath: filepath)
            try data.write(to: path)
        } catch {
            print(error.localizedDescription)
        }

    }

    func retrieveAlbumData() -> [AlbumModel]? {

        guard let filepath = Utility.filePath else {
            return nil
        }
        do {
            let path = URL(fileURLWithPath: filepath)
            let fileData = try Data(contentsOf: path)
            let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as? [AlbumModel]
            return unarchivedData
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

}
