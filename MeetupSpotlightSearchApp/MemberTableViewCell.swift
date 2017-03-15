//
//  MemberTableViewCell.swift
//  MeetupSpotlightSearchApp
//
//  Created by Coy Woolard on 3/13/17.
//  Copyright © 2017 Coy. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    lazy var memberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()

    lazy var memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()

    lazy var memberBioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11.0)
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        memberImageView.image = nil
        memberNameLabel.text = nil
        memberBioLabel.text = nil
    }

    func setup() {

        let stackView = UIStackView(arrangedSubviews: [memberNameLabel, memberBioLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading

        let views: [String: Any] = [
            "imageView": memberImageView,
            "stackView": stackView,
        ]

        contentView.addSubview(memberImageView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[imageView(60)]-[stackView]->=8-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[imageView]-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stackView]-|", options: [], metrics: nil, views: views))

    }

    func display(_ member: Member) {
        memberNameLabel.text = member.name
        memberBioLabel.text = member.bio
        memberImageView.setImageURLString(member)
    }
}
