//
//  SheetEnum.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 15.05.2025.
//

import SwiftUI

protocol SheetEnum: Identifiable, Hashable, Equatable {
    associatedtype Body: View
    var presentationDetents: Set<PresentationDetent> { get }
    var presentationDragIndicator: Visibility { get }
    var interactiveDismissDisabled: Bool { get }

    @MainActor
    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> Body
}
