//
//  UIImageView+Extension.swift
//  unsplash
//
//  Created by Баэль Рыспеков on 27/7/23.
//

import UIKit

extension UIImageView {
    func getImage(from path: String) {
        guard let url = URL(string: path) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

