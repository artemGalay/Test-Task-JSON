//
//  SongCollectionViewCell.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 27.10.22.
//

import UIKit

class SongsCollectionViewCell: UICollectionViewCell {

    lazy var nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(nameSongLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameSongLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameSongLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            nameSongLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
