//
//  Member.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/13/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class Member {

    let identifier: String
    let name: String
    let bio: String
    let city: String
    let imageURLString: String

    var avatar: UIImage? {
        return UIImage.localImage(with: self)
    }

    init(json: JSON) {
        self.identifier = json["id"].stringValue
        self.name = json["name"].stringValue
        self.bio = json["bio"].stringValue
        self.city = json["city"].stringValue
        self.imageURLString = json["photo"]["thumb_link"].stringValue
    }

    var imageFilePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = "\(paths[0])/\(identifier)"
        return filePath
    }
}

extension Member {

    var searchableUniqueIdentifier: String {
        return identifier
    }

    var searchableItemAttributeSetRepresentation: CSSearchableItemAttributeSet {
        let searchableItem = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        searchableItem.title = name
        if let avatar = avatar {
            searchableItem.thumbnailData = UIImagePNGRepresentation(avatar) ?? UIImageJPEGRepresentation(avatar, 0.5) ?? UIImagePNGRepresentation(#imageLiteral(resourceName: "placeholder"))
        }
        searchableItem.contentDescription = bio
        return searchableItem
    }
}
