//
//  PictureViewController.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class PictureViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userAlbum: [UserAlbum] = []
    var albumId: Int = 0
    
    // MARK: - System events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        getPictures()
    }
    
    // MARK: - private functions
    private func setupUI() {
        setNavigationBarTitle(title: Constants.NavigationBarTitle.album)
        collectionView.register(UINib.init(nibName: Constants.Cell.pictureCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.Cell.pictureCollectionViewCell)
    }
    
    private func getPictures() {
        ServicesManager.loadPicturesByAlbumId(albumId: albumId) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                if let userAlbum = result.value {
                    strongSelf.userAlbum = userAlbum
                    strongSelf.collectionView.reloadData()
                } else {
                    strongSelf.showSimpleAlert(title: Constants.Alert.infoText, message: Constants.Alert.message)
                }
                
            case .failure:
                strongSelf.showSimpleAlert(title: Constants.Alert.infoText, message: Constants.Alert.errorText)
            }
        }
    }
}

// MARK: - collectionView datasource
extension PictureViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.pictureCollectionViewCell, for: indexPath) as? PictureCollectionViewCell,
            let picture = userAlbum[safe: indexPath.row] {
            cell.populate(userAlbum: picture)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - collectionView flow layout
extension PictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        return CGSize(width: width * 0.33, height: width * 0.33)
    }
}
