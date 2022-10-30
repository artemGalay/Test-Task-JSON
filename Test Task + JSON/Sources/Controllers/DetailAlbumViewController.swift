//
//  DetailAlbumViewController.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 27.10.22.
//

import UIKit

class DetailAlbumViewController: UIViewController {

    private lazy var albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Name album"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name artist"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var releaseDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Release Data"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var trackCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10 tracks"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView()
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var stackView = UIStackView(arrangeSubview: [albumNameLabel,
                                                              artistNameLabel,
                                                              releaseDataLabel,
                                                              trackCountLabel],
                                             axis: .vertical,
                                             spacing: 10,
                                             distribution: .fillProportionally)

    var album: Album?
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        setModel()
        fetchSong(album: album)
    }

    private func setupHierarchy() {
        view.addSubview(albumLogo)
        view.addSubview(stackView)
        view.addSubview(collectionView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            albumLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            albumLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumLogo.heightAnchor.constraint(equalToConstant: 100),
            albumLogo.widthAnchor.constraint(equalToConstant: 100),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: albumLogo.trailingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }

    private func setModel() {
        guard let album = album else { return }

        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
        releaseDataLabel.text = setDateFormat(date: album.releaseDate)

        guard let url = album.artworkUrl100 else { return }
        setImage(urlString: url)
    }

    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backEndDate = dateFormatter.date(from: date) else { return "" }

        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backEndDate)
        return date
    }

    private func setImage(urlString: String?) {

        if let url = urlString {

            NetworkRequest.shared.requestData(urlString: url) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(let error):
                    self?.albumLogo.image = nil
                    print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            albumLogo.image = nil
        }
    }

    private func fetchSong(album: Album?) {
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id\(idAlbum)&entity=song"

        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songsModel, error in
            if error == nil {
                guard let songsModel = songsModel else { return }
                self?.songs = songsModel.results
                self?.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
                self?.alertOk(title: "Error", message: error!.localizedDescription)
            }
        }
    }
}

extension DetailAlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SongsCollectionViewCell
        let song = songs[indexPath.row].trackName
        cell.nameSongLabel.text = song
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 20)
    }
}
