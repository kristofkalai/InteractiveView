//
//  InteractionManager.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 22..
//

import SwiftUI

public final class InteractionManager: NSObject {
    private final class PanGestureRecognizer: UIPanGestureRecognizer {}
    private final class TapGestureRecognizer: UILongPressGestureRecognizer {
        override init(target: Any?, action: Selector?) {
            super.init(target: target, action: action)
            minimumPressDuration = .zero
        }
    }

    @Published public var interactionType: InteractionType = .none
    @Published public var isGestureAdded = false

    public override init() {
        super.init()
    }
}

extension InteractionManager {
    public func addGesture() {
        guard !isGestureAdded, let rootViewController else { return }
        isGestureAdded = true

        let panGesture = PanGestureRecognizer(target: self, action: #selector(onChangePan(_:)))
        panGesture.delegate = self
        rootViewController.view.addGestureRecognizer(panGesture)

        let tapGesture = TapGestureRecognizer(target: self, action: #selector(onChangeTap(_:)))
        tapGesture.delegate = self
        rootViewController.view.addGestureRecognizer(tapGesture)
    }

    public func removeGesture() {
        guard let rootViewController else { return }
        rootViewController.view.gestureRecognizers?.removeAll {
            $0 is PanGestureRecognizer || $0 is TapGestureRecognizer
        }
        isGestureAdded = false
    }
}

extension InteractionManager: ObservableObject {}

extension InteractionManager: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}

extension InteractionManager {
    @objc private func onChangePan(_ sender: PanGestureRecognizer) {
        switch sender.state {
        case .began: interactionType = .began
        case .changed: interactionType = .changing
        case .ended: interactionType = .ended
        default: interactionType = .none
        }
    }

    @objc private func onChangeTap(_ sender: TapGestureRecognizer) {
        switch sender.state {
        case .began: interactionType = .began
        case .ended: interactionType = .ended
        default: break
        }
    }

    private var windowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first as? UIWindowScene
    }

    private var rootViewController: UIViewController? {
        windowScene?.windows.last?.rootViewController
    }
}
