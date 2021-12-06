//
//  HomeViewModel.swift
//  ECommerceShop (iOS)
//
//  Created by Emanuel Jorge on 05/12/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    // Sample Products...
    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget")
    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type...
    @Published var showMoreProductsOnType: Bool = false
    
    init() {
        filterProductByType()
    }
    
    func filterProductByType() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInitiated).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter{ product in
                    return product.type == self.productType
                }
            // Limiting result...
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
