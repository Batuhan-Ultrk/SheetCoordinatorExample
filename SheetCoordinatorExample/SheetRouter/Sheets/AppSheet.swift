//
//  AppSheet.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 2.01.2026.
//

import SwiftUI

enum AppSheet: SheetEnum {
    case profile
    case settings
    case editName(paramater: NameAndEmailParamaters)

    var presentationDetents: Set<PresentationDetent> { [.large] }
    var presentationDragIndicator: Visibility { .hidden }
    var interactiveDismissDisabled: Bool { false }

    var id: String {
        switch self {
        case .profile:
            return "profileView"
        case .settings:
            return "settingsView"
        case .editName:
            return "editNameView"
        }
    }

    @MainActor
    @ViewBuilder
    func view(coordinator: SheetCoordinator<AppSheet>) -> some View {
        switch self {
        case .profile:
            ProfileView()

        case .settings:
            SettingsView()

        case .editName(let paramater):
            EditNameView(paramater: paramater)
        }
    }
}
