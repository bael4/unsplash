//
//  DetailUnsplashController.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 29/7/23.
//

import UIKit

class DetailUnsplashController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Details"
        let coloredImage = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: .none)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        let turnBackButton = UIBarButtonItem(image: coloredImage, style: .done, target: self, action: #selector(turnBackButtonTapped))
        navigationItem.leftBarButtonItem = turnBackButton
    }
}


extension DetailUnsplashController {
    @objc func turnBackButtonTapped() {
        self.dismiss(animated: true)
    }
}
