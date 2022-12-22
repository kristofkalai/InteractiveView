//
//  InteractionType.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 22..
//

public enum InteractionType: Equatable {
    case none
    case began
    case changing
    case ended
}

extension InteractionType {
    public var isInteracting: Bool {
        switch self {
        case .began, .changing: return true
        default: return false
        }
    }
}
