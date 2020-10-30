//
//  ChallengeListView.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengeListViewModel()
    
    var body: some View {
        Text("Challenge List")
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
