//
//  DetailViewController.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/14/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    init(member: Member) {
        super.init(nibName: nil, bundle: nil)
        title = member.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
