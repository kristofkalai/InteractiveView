//
//  InteractiveView.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 22..
//

import SwiftUI

public struct InteractiveView<Content: View> {
    @StateObject private var interactionManager = InteractionManager()
    private let content: () -> Content
    private let changed: (_ interactionType: InteractionType) -> Void

    public init(content: @escaping () -> Content, changed: @escaping (_ interactionType: InteractionType) -> Void) {
        self.content = content
        self.changed = changed
    }
}

extension InteractiveView: View {
    public var body: some View {
        content()
            .add(interactionManager: interactionManager, changed: changed)
    }
}
