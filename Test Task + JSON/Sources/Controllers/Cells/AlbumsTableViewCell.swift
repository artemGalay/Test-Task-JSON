//
//  AlbumsTableViewCell.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 26.10.22.
//

import UIKit

class AlbumsTableViewCell: UITableViewCell {

    private lazy var albumsLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name album name"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name artist name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "16 tracks"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView = UIStackView(arrangeSubview: [artistNameLabel, trackCountLabel],
                                             axis: .horizontal,
                                             spacing: 10,
                                             distribution: .equalCentering)

    override func layoutSubviews() {
        super.layoutSubviews()
        albumsLogo.layer.cornerRadius = albumsLogo.frame.width / 2
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(albumsLogo)
        addSubview(albumNameLabel)
        addSubview(stackView)
    }

    func configureAlbumCell(album: Album) {

        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumsLogo.image = image
                case .failure(let error):
                    self?.albumsLogo.image = nil
                    print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            albumsLogo.image = nil
        }
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            albumsLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            albumsLogo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            albumsLogo.heightAnchor.constraint(equalToConstant: 60),
            albumsLogo.widthAnchor.constraint(equalToConstant: 60),

            albumNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: albumsLogo.trailingAnchor, constant: 10),
            albumNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            stackView.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: albumsLogo.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
