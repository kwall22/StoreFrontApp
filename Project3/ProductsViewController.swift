//
//  ViewController.swift
//  Project3
//
//  Created by Kassidy Wall on 11/6/23.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var store: ProductStore!
    let productDataSource = ProductDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = productDataSource
        collectionView.delegate = self
        
        store.fetchInterestingProducts {
            (productsResult) in
            switch productsResult {
            case let .success(products):
                print("Successfully found \(products.count) products.")
                self.productDataSource.products = products
            case let .failure(error):
                print("Error fetching interesting products: \(error)")
                self.productDataSource.products.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        let product = productDataSource.products[indexPath.row]

        // Download the image data, which could take some time
        store.fetchImage(for: product) { (result) -> Void in

            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            guard let productIndex = self.productDataSource.products.firstIndex(of: product),
                case let .success(image) = result else {
                    return
            }
            let productIndexPath = IndexPath(item: productIndex, section: 0)

            // When the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: productIndexPath)
                                                         as? ProductCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showProduct":
            if let selectedIndexPath =
                    collectionView.indexPathsForSelectedItems?.first {

                let product = productDataSource.products[selectedIndexPath.row]

                let destinationVC = segue.destination as! ProductInfoViewController
                destinationVC.product = product
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }


}

