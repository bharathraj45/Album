//
//  HomeViewController.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var albums: [Album] = []
    var filteredAlbums: [Album] = []
    var isSearch = false
    
    // MARK: - System events
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAlbums()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //show the screen based on segue identifier
        if segue.identifier == Constants.SegueIdentifiers.homeToPictureView {
            if let pictureViewController = segue.destination as? PictureViewController,
                let indexPath = self.tableview.indexPathForSelectedRow,
                let albumId = albums[safe: indexPath.row]?.id {
                pictureViewController.albumId = albumId
                clearSearch()
            }
        }
    }
    
    // MARK: - private functions
    private func setupUI() {
        setNavigationBarTitle(title: Constants.NavigationBarTitle.albums)
        tableview.register(UINib.init(nibName: Constants.Cell.albumTitleTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Cell.albumTitleTableViewCell)
    }
    
    private func getAlbums() {
        ServicesManager.loadAlbums { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if let albums = result.value {
                    strongSelf.albums = albums
                    strongSelf.tableview.reloadData()
                } else {
                    strongSelf.showSimpleAlert(title: Constants.Alert.infoText, message: Constants.Alert.message)
                }
            case .failure:
                strongSelf.showSimpleAlert(title: Constants.Alert.infoText, message: Constants.Alert.errorText)
            }
        }
    }
}

// MARK: - tableview datasource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? filteredAlbums.count : albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.albumTitleTableViewCell, for: indexPath) as? AlbumTitleTableViewCell {
            if isSearch {
                if let album = filteredAlbums[safe: indexPath.row] {
                    cell.populate(album: album)
                    return cell
                }
            } else {
                if let album = albums[safe: indexPath.row] {
                    cell.populate(album: album)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}

// MARK: - tableview delegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.SegueIdentifiers.homeToPictureView, sender: self)
    }
}

// MARK: - searchbar delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
        getAlbums()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSearchUpdate(searchText: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchUpdate(searchText: searchText)
    }
    
    private func getSearchUpdate(searchText: String) {
        if let searchText = searchBar.text,
            !searchText.isEmpty {
            isSearch = true
            let updatedAlbums = albums.filter({ ($0.title.lowercased().contains(searchText.lowercased())) })
            filteredAlbums = updatedAlbums
        } else {
            isSearch = false
        }
        self.tableview.reloadData()
    }
    
    private func clearSearch() {
        searchBar.resignFirstResponder()
        isSearch = false
        searchBar.text = ""
    }
}
