//
//  NavigationButton.swift
//  SwiftExtended
//
//  Created by Vlad Valkov on 10.08.2021.
//

import SwiftUI

public struct NavigationButton<Destination: View, Label: View>: View {
    @State private var isNavigating = false
    
    var destination: Destination
    var action: () -> Bool
    @ViewBuilder var label: () -> Label


    
    public var body: some View {
        Button(action: {
            isNavigating = action()
        }) {
            label()
        }.overlay(
        NavigationLink(
            destination: destination,
            isActive: $isNavigating,
            label: {
                EmptyView()
            }
        ).hidden()
        )
    }
}
struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationButton(destination: Text("Hello World!"), action: { return true }) {
                Text("Navigate!")
            }
        }
    }
}
