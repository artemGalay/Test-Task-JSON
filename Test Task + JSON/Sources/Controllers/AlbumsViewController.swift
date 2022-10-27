//
//  AlbumsViewController.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 25.10.22.
//

import UIKit

class AlbumsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupSearchController()
        setNavigationBar()

    }

    private func setupHierarchy() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }

    private func createCustomButton(selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }

    private func setNavigationBar() {
        navigationItem.title = "Albums"

        navigationItem.searchController = searchController

        let userInfoButton = createCustomButton(selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
    }

private func setupSearchController() {
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search"
    searchController.obscuresBackgroundDuringPresentation = false
}

    @objc func userInfoButtonTapped() {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
}

extension AlbumsViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumsTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailAlbumViewController = DetailAlbumViewController()
        navigationController?.pushViewController(detailAlbumViewController, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
