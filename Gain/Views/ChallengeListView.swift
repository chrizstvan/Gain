//
//  ChallengeListView.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct ChallengeListView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var viewModel = ChallengeListViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(
                        Rectangle()
                            .fill(Color.red)
                            .cornerRadius(5)
                    )
                }
            } else {
                mainContentView
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(
                    columns: [.init(.flexible(), spacing: 20), .init(.flexible())],
                    spacing: 20
                ) {
                    ForEach(viewModel.itemViewModels, id: \.self) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
            .padding(10)
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .navigationTitle(viewModel.title)
        .sheet(isPresented: $viewModel.showingCreateModal) {
            NavigationView {
                CreateView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

struct ChallengeItemView: View {
    private let viewModel: ChallengeItemViewModel
    
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    // titleRow handle horizontal layout of title
    var titleRow: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
            
            Image(systemName: "trash")
        }
    }
    
    // dailyIncreaseRow handle horizontal layout of daily increase
    var dailyIncreaseRow: some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            
            Spacer()
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                titleRow
                
                ProgressCircleView(
                    viewModel: viewModel.progressCircleVM
                )
                .padding(.vertical, 25)
                
                dailyIncreaseRow
            }
            .padding(.vertical, 10)
            
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(5.0)
        )
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
