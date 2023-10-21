//
//  View+Extensions.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 22..
//

import SwiftUI

extension View {
    public func add(interactionManager: InteractionManager,
                    changed: @escaping (_ interactionType: InteractionType) -> Void) -> some View {
        onAppear(perform: interactionManager.addGesture)
            .onDisappear(perform: interactionManager.removeGesture)
            .onChange(of: interactionManager.interactionType, perform: changed)
    }
}
