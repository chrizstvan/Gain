//
//  DropdownView.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct DropdownView<T: DropdownItemProtocol>: View {
    
    @Binding var viewModel: T
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                
                Spacer()
            }
            .padding(.vertical, 10)
            
            Button(action: {
                self.viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropdownTitle)
                        .font(.system(size: 28, weight: .semibold))
                    
                    Spacer()
                    
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }
        .padding(15)
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                Text("Placeholder")
                //DropdownView()
            }
            NavigationView {
                Text("Placeholder")
                //DropdownView()
            }
            .environment(\.colorScheme, .dark)
        }
    }
}