//
//  Product.swift
//  Project3
//
//  Created by Kassidy Wall on 11/6/23.
//

import Foundation

class Product: Codable {
    let title: String
    let productID: Int
    let imageURL: URL?
    let price: Float
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case productID = "id"
        case imageURL = "image"
        case price
        case description
    }
    
    
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        // Two Products are the same if they have the same productID
        return lhs.productID == rhs.productID
    }
}

