//
//  ContentView.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 44, weight: .medium))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            self.viewModel.createPushed = true
        }) {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: viewModel.createButtonImageName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text(viewModel.createButtonTitle)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
      
    var alreadyButton: some View {
        Button(viewModel.alreadyButtonTitle) {
            self.viewModel.loginSignUpPushed = true
        }
        .foregroundColor(.white)
    }
    
    var backgroundImage: some View {
        Image(viewModel.backgroundImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.black.opacity(0.4))
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                        .frame(height: proxy.size.height * 0.18)
                    
                    title
                    
                    Spacer()
                    
                    //Navigation Action here
                    NavigationLink(destination: CreateView(), isActive: self.$viewModel.createPushed) {}
                    
                    createButton
                        .padding(.horizontal, 25)
                        .buttonStyle(PrimaryButtonStyle())
                    
                    NavigationLink(
                        destination: LoginSignUpView(
                            viewModel: .init(
                                mode: .login,
                                isPushed: $viewModel.loginSignUpPushed
                            )
                        ),
                        isActive: self.$viewModel.loginSignUpPushed,
                        label: {
                            //empty
                        })
                    
                    alreadyButton
                        .padding(10)
                    
                    Spacer().frame(height: proxy.size.height * 0.05)
                    
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    backgroundImage
                        .frame(width: proxy.size.width)
                        
                )
                .edgesIgnoringSafeArea(.all)
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandingView()
                .previewDevice("iPhone 11 Pro Max")
                .previewDisplayName("iPhone 11 Pro Max")
            LandingView()
                .previewDevice("iPhone SE")
                .previewDisplayName("iPhone SE")
            LandingView()
            .previewDevice("iPhone 8 Plus")
            .previewDisplayName("iPhone 8+")
        }
    }
}
