//
//  MemberDatasource.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/14/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit
import CoreSpotlight

class MemberDataSource: NSObject {

    var members = [Member]()

    override init() {
        super.init()
        if let json = JSONHelper.loadLocalJSONFile("members") {
            if let members = json["results"].array {
                self.members = members.map { Member(json: $0) }
                
            }
        }
    }
}

extension MemberDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = members[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MemberTableViewCell else {
            fatalError("this cell should exist")
        }
        cell.display(member)
        return cell
    }
}

extension MemberDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in

            tableView.beginUpdates()
            tableView.deleteRows(at: [index], with: .fade)
            let member = self.members.remove(at: index.row)
            self.deleteSearchableItemFromIndex(member)
            tableView.endUpdates()
        }
        return [deleteAction]
    }
}

extension MemberDataSource {

    func deleteSearchableItemFromIndex(_ member: Member) {
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: [member.identifier], completionHandler: { (error) in
            if let _ = error {
                print("There was an error removing \(member.name) with identifier \(member.identifier)")
            }
        })
    }
}
