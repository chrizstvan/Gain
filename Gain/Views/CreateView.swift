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
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: self.$viewModel.dropdowns[index])
        }
    }
    
    var actionSheet: ActionSheet {
        ActionSheet(title: Text("Select noh"),
                    buttons: viewModel.displayedOption.indices.map { index in
                        let option = viewModel.displayedOption[index]
                        return ActionSheet.Button.default(Text(option.formatedValue)) {
                            //selected option button index
                            self.viewModel.send(action: .selectedOption(index: index))
                        }
        } )
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
            .actionSheet(isPresented: Binding<Bool>(get: {
                self.viewModel.hasSelectedDropdown
            }, set: { _ in
                
            }), content: { () -> ActionSheet in
                self.actionSheet
            })
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
