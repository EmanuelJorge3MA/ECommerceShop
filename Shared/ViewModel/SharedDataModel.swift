//
//  SharedDataModel.swift
//  ECommerceShop (iOS)
//
//  Created by Emanuel Jorge on 09/12/21.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    // Detail Product Data...
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // matched Geometry Effect from Search Page...
    @Published var fromSearchPage: Bool = false
    
    // Liked Products...
    @Published var likedProducts: [Product] = []
    
    // basket Products...
    @Published var cartProducts: [Product] = []
    
    // Calculating Total price...
    func getTotalPrice() -> String {
        var total: Int = 0
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        return "$\(total)"
    }
}
