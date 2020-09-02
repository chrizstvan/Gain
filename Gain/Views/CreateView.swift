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
    @State private var isActive = false
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: self.$viewModel.dropdowns[index])
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
               dropdownList
                Spacer()
                
                NavigationLink(destination: RemindView(), isActive: $isActive) {
                    Button(action: {
                        self.isActive = true
                    }) {
                        Text("Next").font(.system(size: 24, weight: .medium))
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
        }
    }
    
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateView()
                .previewDevice("iPhone 11 Pro Max")
                .previewDisplayName("iPhone 11 Pro Max")
        }
        
    }
}
