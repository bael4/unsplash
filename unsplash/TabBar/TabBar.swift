//
//  TabBar.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 25/7/23.
//

import UIKit

class TabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
        tabBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    private func setupChildViewControllers() {
        let mainViewMocel = MainViewModel()
        let mainViewController = MainViewController()
        mainViewController.viewModel = mainViewMocel
        let favouriteViewController = FavouriteViewController()
        let mainIcon = UIImage(systemName: "house.fill")
        let favouriteIcon = UIImage(systemName: "heart")
        
        viewControllers = [
            generateNavigatonController(
                rootViewController: mainViewController,
                image: mainIcon!),
            generateNavigatonController(
                rootViewController: favouriteViewController,
                image: favouriteIcon!)]
    }
    
    func generateNavigatonController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let navigaionController = UINavigationController(rootViewController: rootViewController)
        navigaionController.tabBarItem.image = image
        return navigaionController
    }
}


