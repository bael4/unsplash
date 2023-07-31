//
//  ImagesCell.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import UIKit

protocol FavouritDelegate: AnyObject {
    func favouriteTapped(id: String)
    func removeTapped(id: String)
}

class ImageCell: UICollectionViewCell {
    
    
    static let reuseId = "idCell"
    
    private var id: String?
    
    var model: Unsplash?
    
    weak var delegate: FavouritDelegate?
    
    private var isFavorited: Bool {
        get {
            let key = model?.id ?? ""
            let value = UserDefaults.standard.bool(forKey: key)
            return value
        }
        set {
            let key = model?.id ?? ""
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }



    private let imageVIew: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Hi"
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var favouriteImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.isUserInteractionEnabled = true
        view.tintColor = .red
        let tap = UITapGestureRecognizer(target: self, action: #selector(favouriteTapped))
        view.addGestureRecognizer(tap)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        onAddSubviews()
        onConfigureView()
        onSetupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func onConfigureView() {
        backgroundColor = .white
    }
    
    private func onAddSubviews() {
        addSubviews(
            imageVIew,
            descriptionLabel,
            favouriteImageView
        )
    }
    
    private func onSetupConstraints() {
        imageVIew.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        favouriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageVIew.topAnchor.constraint(equalTo: topAnchor),
            imageVIew.leftAnchor.constraint(equalTo: leftAnchor),
            imageVIew.rightAnchor.constraint(equalTo: rightAnchor),
            imageVIew.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: imageVIew.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
             favouriteImageView.topAnchor.constraint(equalTo: imageVIew.topAnchor, constant: 20),
             favouriteImageView.rightAnchor.constraint(equalTo: imageVIew.rightAnchor, constant: -10),
             favouriteImageView.widthAnchor.constraint(equalToConstant: 20),
             favouriteImageView.heightAnchor.constraint(equalToConstant: 20)
         ])
    }
    
    func configureCell(model: Unsplash) {
        self.model = model
        descriptionLabel.text = model.alt_description
        imageVIew.getImage(from: model.urls.full)
        id = model.id
        updateFavouriteImage()
    }
    
    private func updateFavouriteImage() {
        let imageName = isFavorited ? "heart.fill" : "heart"
        favouriteImageView.image = UIImage(systemName: imageName)
        if let id = id {
            delegate?.favouriteTapped(id: id)
        }
    }

}

extension ImageCell {
    @objc func favouriteTapped() {
        isFavorited.toggle()
        updateFavouriteImage()
    }
}

