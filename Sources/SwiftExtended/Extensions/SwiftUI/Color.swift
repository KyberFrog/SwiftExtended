//
//  Color.swift
//  
//
//  Created by vladIcedigital on 12.08.2021.
//
// Implements using named assets (using from .xcassets)
//

import Foundation
import SwiftUI


public extension Color {
    public init(named: String) {
        self.init(color: UIColor(named: named))
    }
}
