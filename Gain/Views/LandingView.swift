//
//  ContentView.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                    .frame(height: proxy.size.height * 0.18)
                
                Text("No Pain, No Gain")
                    .font(.system(size: 44, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 15) {
                        Spacer()
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Create a Challenge")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(.horizontal, 25)
                .buttonStyle(PrimaryButtonStyle())
                
                Spacer().frame(height: proxy.size.height * 0.05)
                
            }.frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(
                Image("pullup")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color.black.opacity(0.4))
                    .frame(width: proxy.size.width)
                    
            )
            .edgesIgnoringSafeArea(.all)
        }
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
