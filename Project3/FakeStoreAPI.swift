//
//  FakeStoreAPI.swift
//  Project3
//
//  Created by Kassidy Wall on 11/6/23.
//

import Foundation

enum EndPoint: String {
    case interestingProducts = "products"
}


struct FakeStoreAPI {
    
    private static let baseURLString = "https://fakestoreapi.com/products"
    
    private static func fakeStoreURL(endPoint: EndPoint) -> URL {
        
        let components = URLComponents(string: baseURLString)! //used to be var 
        
        return components.url!
    }
    
    static var interestingProductsURL: URL {
        return fakeStoreURL(endPoint: .interestingProducts)
    }
    
    static func products(fromJSON data: Data) -> Result<[Product], Error> {
        do {
            let decoder = JSONDecoder()
            let fakestoreResponse = try decoder.decode([Product].self, from: data)
            return .success(fakestoreResponse)
        } catch {
            return .failure(error)
        }
    }
}
