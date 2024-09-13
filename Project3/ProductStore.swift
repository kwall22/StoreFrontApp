//
//  ProductStore.swift
//  Project3
//
//  Created by Kassidy Wall on 11/6/23.
//

import UIKit

enum ProductError: Error {
    case imageCreationError
    case missingImageURL
}


class ProductStore {
    
    let imageStore = ImageStore()
    private let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
    
    func fetchImage(for product: Product,
                    completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let productKey = String(product.productID)
            if let image = imageStore.image(forKey: productKey) {
                OperationQueue.main.addOperation {
                    completion(.success(image))
                }
                return
            }
        
        guard let imageURL = product.imageURL else {
            completion(.failure(ProductError.missingImageURL))
            return
        }
        
        let request = URLRequest(url: imageURL)

        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                    self.imageStore.setImage(image, forKey: productKey)
            }
            
            OperationQueue.main.addOperation {
                        completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?,
                                     error: Error?) -> Result<UIImage, Error> {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {

                // Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ProductError.imageCreationError)
                }
        }
        return .success(image)
    }
    
    
    func fetchInterestingProducts(completion: @escaping (Result<[Product], Error>) -> Void) {

        let url = FakeStoreAPI.interestingProductsURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processProductsRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
  
    private func processProductsRequest(data: Data?,
                                      error: Error?) -> Result<[Product], Error> {
        guard let jsonData = data else {
            
            return .failure(error!)
        }
        
        return FakeStoreAPI.products(fromJSON: jsonData)
    }
    
    
    
    
    
    
}


