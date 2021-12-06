//
//  MainPage.swift
//  ECommerceShop (iOS)
//
//  Created by Emanuel Jorge on 05/12/21.
//

import SwiftUI

struct MainPage: View {
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    // Hiding Tab Bar...
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Tab View...
            TabView(selection: $currentTab) {
                
                Home()
                    .tag(Tab.Home)
                
                Text("Liked")
                    .tag(Tab.Liked)
                
                Text("Profile")
                    .tag(Tab.Profile)
                
                Text("Cart")
                    .tag(Tab.Cart)
            }
            
            // Custom Tab Bar...
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button{
                        // updating tab...
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        //Applying little shadow at bg...
                            .background(
                                Color.purple // MARK: - Definir Cor no Assets
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring...
                                    .blur(radius: 5)
                                // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? .purple : Color.black.opacity(0.3)) // MARK: - Definir Cor no Assets
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
        .background(Color.gray.opacity(0.2).ignoresSafeArea()) // MARK: - Definir Cor no Assets
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Making Case Iteratable...
// Tab Cases...
enum Tab: String, CaseIterable {
    
    // Raw Value must be image Name in asset...
    case Home = "house.fill"
    case Liked = "suit.heart.fill"
    case Profile = "person.fill"
    case Cart = "cart.fill"
}
