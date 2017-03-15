//
//  JSONHelper.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/13/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import Foundation

class JSONHelper {

    class func loadLocalJSONFile(_ fileName: String, ofType type: String = "json") -> JSON? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return nil }
        let url = URL(fileURLWithPath: filePath)
        guard let jsonData = try? Data(contentsOf: url, options: .mappedIfSafe) else { return nil }
        return JSON(data: jsonData)
    }
}
