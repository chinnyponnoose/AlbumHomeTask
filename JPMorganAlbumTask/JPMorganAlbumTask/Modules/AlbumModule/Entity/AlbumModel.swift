//
//  AlbumModel.swift
//  JPMprgan Albums Task
//
//  Created by Chinny Ponnoose on 29/01/22.
//

import Foundation

public class AlbumModel: NSObject, Codable, NSCoding {

    var id: Int
    var userId: Int
    var title: String

    init(id: Int, userId: Int, title: String) {
        self.id = id
        self.userId = userId
        self.title = title
    }

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
    }

    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeInt32(forKey: CodingKeys.id.rawValue)
        let userId = coder.decodeInt32(forKey: CodingKeys.userId.rawValue)
        let title = coder.decodeObject(forKey: CodingKeys.title.rawValue) as? String ?? ""
        self.init(id: Int(id), userId:
                    Int(userId), title: title)
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: CodingKeys.id.rawValue)
        aCoder.encode(userId, forKey: CodingKeys.userId.rawValue)
        aCoder.encode(title, forKey: CodingKeys.title.rawValue)
    }

}
