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
        Product(type: .Wearable, title: "OnePlus", subtitle: "Black v3", price: "$209", productImage: "watch1"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "13 - Black", price: "$109", productImage: "watch2"),
        Product(type: .Wearable, title: "OnePlus", subtitle: "White", price: "$129", productImage: "watch3"),
        Product(type: .Wearable, title: "Apple Watch", subtitle: "Series 7", price: "$189", productImage: "watch4"),
        Product(type: .Wearable, title: "Huawei", subtitle: "GT 3", price: "$219", productImage: "watch5"),
        Product(type: .Wearable, title: "Xiaomi", subtitle: "Mi Band 5", price: "$309", productImage: "watch6"),
        
        Product(type: .Phones, title: "iPhone", subtitle: "13 - Rose", price: "$999", productImage: "iphone1"),
        Product(type: .Phones, title: "Samsung", subtitle: "Galaxy Z Flip", price: "$589", productImage: "sg1"),
        Product(type: .Phones, title: "iPhone", subtitle: "13 - Gold", price: "$999", productImage: "iphone2"),
        Product(type: .Phones, title: "iPhone", subtitle: "13 - Black", price: "$999", productImage: "iphone3"),
        Product(type: .Phones, title: "iPhone", subtitle: "13 - Purple", price: "$899", productImage: "iphone4"),
        Product(type: .Phones, title: "Xiaomi", subtitle: "Redmi Note 8", price: "$799", productImage: "huawei1"),
        Product(type: .Phones, title: "Xiaomi", subtitle: "M1 9 GreenLand", price: "$669", productImage: "huawei2"),
        Product(type: .Phones, title: "Xiaomi", subtitle: "M1 11 Gold", price: "$899", productImage: "huawei3"),
        Product(type: .Phones, title: "Samsung", subtitle: "Galaxy S20", price: "$869", productImage: "android1"),
        Product(type: .Phones, title: "Huawei", subtitle: "GT 2", price: "$599", productImage: "red1"),
        Product(type: .Phones, title: "Samsung", subtitle: "Galaxy S19", price: "$599", productImage: "sg3"),
        
        Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 Max", price: "$2269", productImage: "mac2"),
        Product(type: .Laptops, title: "MacBook Pro", subtitle: "M1 Pro", price: "$1869", productImage: "mac3"),
        Product(type: .Laptops, title: "HP", subtitle: "Series Omen", price: "$1869", productImage: "hpomen1"),
        Product(type: .Laptops, title: "MacBook Desk", subtitle: "M1 mini", price: "$1269", productImage: "macdek1"),
        Product(type: .Laptops, title: "MacBook Air", subtitle: "Air Intel", price: "$1169", productImage: "mackair1"),
        Product(type: .Laptops, title: "MacBook Desk", subtitle: "Intel 8", price: "$1369", productImage: "mackdek2"),
        
    
        Product(type: .Tablets, title: "iPad", subtitle: "Pro", price: "$469", productImage: "ipad1"),
        Product(type: .Tablets, title: "iPad", subtitle: "Pro", price: "$769", productImage: "ipad2"),
        Product(type: .Tablets, title: "iPad", subtitle: "Pro", price: "$969", productImage: "ipad3")
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
