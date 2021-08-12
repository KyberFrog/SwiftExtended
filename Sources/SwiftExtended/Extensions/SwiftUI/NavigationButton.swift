//
//  NavigationButton.swift
//  SwiftExtended
//
//  Created by vladIcedigital on 10.08.2021.
//
// Implements Navigation Button.
//
// Label is a closure returning a View
// Action is a function checking if the navigation should complete.
// Destination is a NavigationLink destination.
//

import SwiftUI

public struct NavigationButton<Destination: View, Label: View>: View {
    @State private var isNavigating = false
    
    var destination: Destination
    var action: () -> Bool
    @ViewBuilder var label: () -> Label

    public init(destination: Destination, action: @escaping () -> Bool, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.action = action
        self.label = label
    }
    
    
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
