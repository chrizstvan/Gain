//
//  PrimaryButtonStyle.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .darkPrimaryButton
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor: fillColor)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8.0).fill(fillColor))
        }
    }
}


struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Create a challange")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
