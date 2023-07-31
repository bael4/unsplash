//
//  ViewController.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 25/7/23.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelLogic?
    
    let defaults = UserDefaults.standard

    var images: [Unsplash] = [] {
        didSet {
            DispatchQueue.main.async {
                self.imagesCollection.reloadData()
            }
        }
    }

    private lazy var imagesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize (
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - 120
        )
        layout.minimumLineSpacing = 40
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        onConfigureController()
        onBindViewModel()
        onAddSubView()
        onSetupConstraints()
    }
    
    private func onConfigureController() {
        title = "Изображения"
    }

    private func onBindViewModel() {
        viewModel?.getImages { result in
            self.images = result
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


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        cell.configureCell(model: images[indexPath.row])
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailUnsplashController()
        let nav = UINavigationController(rootViewController: vc)
        navigationController?.present(nav, animated: true)
    }
}

extension MainViewController: FavouritDelegate {
    func favouriteTapped(id: String) {
        viewModel?.saveFavouriteImages(id: id)
    }
    
    func removeTapped(id: String) {
        
    }
}

