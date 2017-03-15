//
//  AppDelegate.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/13/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dataSource = MemberDataSource()

    lazy var membersViewController: MemberTableViewController = {
        return MemberTableViewController(self.dataSource)
    }()

    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.membersViewController)
        return navigationController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.backgroundColor = UIColor.black
        window?.makeKeyAndVisible()

        setupSearchableItems()

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        switch userActivity.activityType {
        case CSSearchableItemActionType:
            guard let searchIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String else { return false }
            guard let objectId = searchIdentifier.components(separatedBy: ".").last else { return false }
            let filteredMembers = dataSource.members.filter { $0.identifier == objectId }
            guard let member = filteredMembers.first else { return false }
            membersViewController.selected(member)
            return true
        default:
            return false
        }
    }
}


extension AppDelegate {

    func setupSearchableItems() {

        //No all devices support indexing
        guard CSSearchableIndex.isIndexingAvailable() else { return }

        var searchableItems = [CSSearchableItem]()

        for (_, member) in dataSource.members.enumerated() {
            let item = CSSearchableItem(uniqueIdentifier: member.searchableUniqueIdentifier, domainIdentifier: "MeetupSpotlightSearchApp", attributeSet: member.searchableItemAttributeSetRepresentation)
            searchableItems.append(item)
        }

        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
