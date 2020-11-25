//
//  ChallengeItemView.swift
//  Gain
//
//  Created by christian on 25/11/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

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
                .onTapGesture {
                    viewModel.tappedDelete()
                }
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

struct ChallengeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeItemView(
            viewModel: .init(
                .init(exercise: "", startAmount: 0, increase: 0, length: 0, userId: "", startDate: Date()),
                onDelete: { _ in }))
    }
}
