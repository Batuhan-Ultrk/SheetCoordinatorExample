//
//  SettingsView.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 2.01.2026.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSheetCoordinator: SheetCoordinator<AppSheet>

    var body: some View {
        bodyView
    }

    var bodyView: some View {
        VStack(spacing: 8) {
            Text("Settings View")

            Button {
                appSheetCoordinator.presentSheet(.editName)
            } label: {
                Text("Go To Edit Name View")
            }

            Button {
                appSheetCoordinator.popToPrevious()
            } label: {
                Text("Go To Back")
            }

            Button {
                appSheetCoordinator.sheetDismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

#Preview {
    SettingsView()
}
