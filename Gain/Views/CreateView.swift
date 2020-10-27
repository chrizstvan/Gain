//
//  CreateView.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    
    @ObservedObject var viewModel = CreateChallangeViewModel()
    
    var dropdownList: some View {
        VStack {
            DropdownView(viewModel: $viewModel.exerciseDropdowns)
            
            DropdownView(viewModel: $viewModel.startAmountDropdowns)
            
            DropdownView(viewModel: $viewModel.increaseDropdowns)
            
            DropdownView(viewModel: $viewModel.lengthDropdowns)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                
                Button(action: {
                    self.viewModel.send(action: .createChallenge)
                }) {
                    Text("Create").font(.system(size: 24, weight: .medium))
                }
            }
            .padding(.bottom, 30)
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CreateView()
            }
            
            NavigationView {
                CreateView()
                .previewDisplayName("iPhone 8+")
            }
            .environment(\.colorScheme, .dark)
        }
        
    }
}
