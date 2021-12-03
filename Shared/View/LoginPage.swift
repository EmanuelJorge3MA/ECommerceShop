//
//  LoginPage.swift
//  ECommerceShop (iOS)
//
//  Created by Emanuel Jorge on 03/12/21.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    var body: some View {
        VStack {
            
            // Welcome Back text for 3 half of the screen...
            
                Text("Welcome\nback")
                    .font(.custom(customFont, size: 55).bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: getRect().height / 3.5)
                    .padding()
                    .background(
                        
                        ZStack {
                           
                            // Gradient Circle...
                            LinearGradient(colors: [
                                Color(.purple), // MARK: - Definir Cor no Assets
                                Color(.blue).opacity(0.2), // MARK: - Definir Cor no Assets
                                Color(.purple) // MARK: - Definir Cor no Assets
                            ], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(.trailing)
                                .offset(y: -25)
                                .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                                .frame(width: 23, height: 23)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading, 30)
                        }
                    )
            
            ScrollView(.vertical, showsIndicators: false) {
                // Login Page From...
                VStack(spacing: 15) {
                    
                    Text("Login")
                        .font(.custom(customFont, size:22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Custom Text Field...
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "justine@gmail.com", value: $loginData.email, showPassord: .constant(false))
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginData.email, showPassord: $loginData.showPassowrd)
                        .padding(.top, 10)
                    
                    // Register Reenter Password
                    if loginData.registerUser {
                        CustomTextField(icon: "envelope", title: "Email", hint: "justine@gmail.com", value: $loginData.email, showPassord: $loginData.showPassowrd)
                            .padding(.top, 10)
                    }
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // Applying Custom Corners...
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.purple) // MARK: - Definir Cor no Assets
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassord: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            TextField(hint, text: value)
                .padding(.top, 2)
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
