//
//  ViewController.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/13/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit

class MemberTableViewController: UIViewController {

    var dataSource: MemberDataSource

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemberTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.rowHeight = 76
        return tableView
    }()

    convenience init(_ dataSource: MemberDataSource) {
        self.init(nibName: nil, bundle: nil)
        setup()
        self.dataSource = dataSource
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.dataSource = MemberDataSource()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        title = "Meetup Members"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

        tableView.reloadData()
    }

    func selected(_ member: Member) {
        navigationController?.popToRootViewController(animated: false)

        let detailViewController = DetailViewController(member: member)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
}
