//
//  FavouriteViewController.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 25/7/23.
//

import UIKit

protocol FavouriteDelegate: AnyObject {
    func didUpdateFavoriteImages()
}


class FavouriteViewController: UIViewController {
    
    var favoriteImages: [Unsplash] = [] {
        didSet{
            imagesCollection.reloadData()
        }
    }
    
    private var viewModel: FavouriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        viewModel = FavouriteViewModel()
        onAddSubView()
        onSetupConstraints()
    }

    private lazy var imagesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize (
            width: UIScreen.main.bounds.width - 20,
            height: UIScreen.main.bounds.height/2
        )
        layout.minimumLineSpacing = 40
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           let images = viewModel.getFavouriteImages()
           favoriteImages = images
        DispatchQueue.main.async {
            self.imagesCollection.reloadData()
        }
    }
    
    private func onAddSubView() {
        view.addSubview(imagesCollection)
    }
    
    private func onSetupConstraints() {
        imagesCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagesCollection.topAnchor.constraint(equalTo: view.topAnchor),
            imagesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imagesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}

extension FavouriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImageCell.reuseId,
            for: indexPath
        ) as? ImageCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: favoriteImages[indexPath.row])
        return cell
    }
}



