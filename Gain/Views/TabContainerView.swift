//
//  TabContainerView.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct TabContainerView: View {
    @StateObject private var tabContainerViewModel = TabCOntainerViewModel()
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemViewModels, id: \.self) { vm in
                self.tabView(for: vm.type)
                    .tabItem {
                        Image(systemName: vm.imageName)
                        Text(vm.title)
                    }
                    .tag(vm.type)
            }
        }
        .accentColor(.primary)
    }
    
    @ViewBuilder func tabView(for tabItemType: TabItemViewModel.TabItemType) -> some View {
        switch tabItemType {
        case .log:
            Text("Log")
        case .challengeList:
            Text("Challenge List")
        case .settings:
            Text("Settings")
        }
    }
}

final class TabCOntainerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        TabItemViewModel(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        TabItemViewModel(imageName: "gear", title: "Settings", type: .settings)
    ]
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}

