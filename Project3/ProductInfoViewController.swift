//
//  ProductInfoViewController.swift
//  Project3
//
//  Created by Kassidy Wall on 11/9/23.
//

import UIKit

class ProductInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
   // let titleLabel.text = product.title
    
    var product: Product! {
        
        didSet {
            navigationItem.title = "Fake Store Item"
        }
    }
    var store = ProductStore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = product.title
        priceLabel.text = "$" + String(product.price)
        descriptionLabel.text = product.description
        
        store.fetchImage(for: product) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for product: \(error)")
            }
        }
    }
}
