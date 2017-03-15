//
//  UIImage+Cache.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/14/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit
import CoreSpotlight

extension UIImageView {

    func setImageURLString(_ member: Member) {

        if let localImage = UIImage.localImage(with: member) {
            image = localImage
            return
        }

        guard let url = URL(string: member.imageURLString), member.imageURLString != "" else {
            image = #imageLiteral(resourceName: "placeholder")
            return
        }

        image = #imageLiteral(resourceName: "placeholder")

        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }

                // Save image.
                let imageData = UIImagePNGRepresentation(image) ?? UIImageJPEGRepresentation(image, 1.0) ?? nil
                try? imageData?.write(to: URL(fileURLWithPath: member.imageFilePath))
                DispatchQueue.main.async {
                    self.image = image

                    let item = CSSearchableItem(uniqueIdentifier: member.searchableUniqueIdentifier, domainIdentifier: "MeetupSpotlightSearchApp", attributeSet: member.searchableItemAttributeSetRepresentation)
                    CSSearchableIndex.default().indexSearchableItems([item], completionHandler: { (error) in
                        print("na son")
                    })
                }
            }
            task.resume()
        }
    }
}

extension UIImage {

    class func localImage(with member: Member) -> UIImage? {
        if let imageData = try? Data(contentsOf: URL(fileURLWithPath: member.imageFilePath)) {
            if let cachedImage = UIImage(data: imageData) {
                return cachedImage
            }
        }
        return nil
    }
}
