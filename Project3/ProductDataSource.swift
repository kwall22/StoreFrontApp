//
//  ProductDataSource.swift
//  Project3
//
//  Created by Kassidy Wall on 11/8/23.
//

import UIKit

class ProductDataSource: NSObject, UICollectionViewDataSource {

    var products = [Product]()
    
    func collectionView(_ collectionView: UICollectionView,
                            numberOfItemsInSection section: Int) -> Int {
            return products.count
        }

    func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let identifier = "ProductCollectionViewCell"
        let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                   for: indexPath) as! ProductCollectionViewCell
        
        let product = products[indexPath.row]
        
        cell.update(displaying: nil)
        cell.priceLabel.text = "$" + String(product.price)
        //cell.titleLable.text = product.title
        
        return cell
    }

}
