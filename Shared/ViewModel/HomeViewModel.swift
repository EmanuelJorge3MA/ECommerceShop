//
//  HomeViewModel.swift
//  ECommerceShop (iOS)
//
//  Created by Emanuel Jorge on 05/12/21.
//

import SwiftUI

// Using Combine to monitor search field and if user leaves for .5 secs then starts searching...
// to avoid memory issue...
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    // Sample Products...
    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Laptops, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Phones, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$369", productImage: "gadget")
    ]
    
    // Filtered Products...
    @Published var filteredProducts: [Product] = []
    
    // More products on the type...
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data...
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    @Published var searchedProducts: [Product]?
    
    var searchCancellable: AnyCancellable?
    
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                }
                else {
                    self.searchedProducts = nil
                }
            })
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
    
    func filterProductBySearch() {
        
        // Filtering Product By Product Type...
        DispatchQueue.global(qos: .userInitiated).async {
            
            let results = self.products
            // Since it will require more memory so were using lazy to perform more...
                .lazy
                .filter{ product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
