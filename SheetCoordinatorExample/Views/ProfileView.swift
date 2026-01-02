//
//  ProfileView.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 2.01.2026.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appSheetCoordinator: SheetCoordinator<AppSheet>

    var body: some View {
        bodyView
    }

    var bodyView: some View {
        VStack(spacing: 8) {
            Text("Profile View")

            Button {
                appSheetCoordinator.presentSheet(.settings)
            } label: {
                Text("Go To Settings View")
            }

            Button {
                appSheetCoordinator.popToPrevious()
            } label: {
                Text("Go To Back")
            }
        }
    }
}

#Preview {
    ProfileView()
}
