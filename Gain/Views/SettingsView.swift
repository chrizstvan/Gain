//
//  SettingsView.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        List(viewModel.itemViewModels.indices, id: \.self) { index in
            Button(action: {
                viewModel.tappedItem(at: index)
            }, label: {
                HStack {
                    Image(systemName: viewModel.item(at: index).iconName)
                    
                    Text(viewModel.item(at: index).titel)
                }
                .background(
                    NavigationLink(
                        destination: LoginSignUpView(viewModel: .init(mode: .signup)),
                        isActive: $viewModel.loginSignupPushed,
                        label: {
                            //Empty
                        })
                )
            })
        }
        .navigationTitle(viewModel.title)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
