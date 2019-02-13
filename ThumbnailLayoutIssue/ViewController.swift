//
//  ViewController.swift
//  ThumbnailLayoutIssue
//
//  Created by Ricardo Pereira on 12/02/2019.
//  Copyright © 2019 Whitesmith. All rights reserved.
//

import UIKit

class ThumbnailTableViewCell: UITableViewCell {

    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIdentifier = "thumbnail-image"
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var thumbnailBackgroundView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "thumbnail-image-background"
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var stackBackgroundView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "background"
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .blue

        contentView.addSubview(thumbnailImageView)

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        contentView.insertSubview(thumbnailBackgroundView, belowSubview: thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailBackgroundView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: -4),
            thumbnailBackgroundView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: -4),
            thumbnailBackgroundView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 4),
            thumbnailBackgroundView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 4),
            ])

        #warning("If I force a fixed height then everything goes well:")
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            thumbnailImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 95),
            thumbnailImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -95),
            //thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 138/90)
            // Height for iPhone X/XS:
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 235)
            ])

        contentView.insertSubview(stackBackgroundView, belowSubview: thumbnailBackgroundView)
        NSLayoutConstraint.activate([
            stackBackgroundView.topAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            stackBackgroundView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 5),
            stackBackgroundView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5),
            stackBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5)
            ])

        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: stackBackgroundView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: stackBackgroundView.trailingAnchor, constant: -15),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
            ])

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(authorLabel)
    }

    func configure() {
        titleLabel.text = "Aslkdjf alçksjdf lkajsdlkçfasd"
        subtitleLabel.text = "ASLÇkdjasçldkjfasd kjfaçlksd jfçlkajs dlkfjalksd jfkajsd klfajsdk jfalksjd lfkjasdkj façlsj dçflajsdç lkfjasla sdjf laksjdflkaj sdkfj açlksdjfl kajsdfljaslkdfj alsdjf çlajsdl kfjaslkd jf"
        authorLabel.text = "John Doe"

        thumbnailImageView.image = UIImage(named: "BookCover")
    }

}

class ViewController : UITableViewController {

    init() {
        super.init(style: .plain)
        tableView.separatorStyle = .none
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ThumbnailTableViewCell.self, forCellReuseIdentifier: "ThumbnailTableViewCell")
        tableView.cellLayoutMarginsFollowReadableWidth = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailTableViewCell", for: indexPath) as? ThumbnailTableViewCell else {
            return UITableViewCell()
        }
        cell.configure()
        return cell
    }

}

