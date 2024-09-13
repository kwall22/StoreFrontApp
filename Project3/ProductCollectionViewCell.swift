//
//  ProductCollectionViewCell.swift
//  Project3
//
//  Created by Kassidy Wall on 11/9/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    //@IBOutlet var titleLable: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!

    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
}
