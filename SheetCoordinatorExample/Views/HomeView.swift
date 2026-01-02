//
//  HomeView.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 2.01.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject var appSheetCoordinatorEmbedded = SheetCoordinator<AppSheet>(mode: .embedded)
    @StateObject var appSheetCoordinatorStacked = SheetCoordinator<AppSheet>(mode: .stacked)

    var body: some View {
        bodyView
            .sheetHost(appSheetCoordinatorEmbedded)
            .sheetHost(appSheetCoordinatorStacked)
    }

    var bodyView: some View {
        VStack(spacing: 8) {
            Button {
                appSheetCoordinatorEmbedded.presentSheet(.profile)
            } label: {
                Text("Go To Profile View Embedded Mode")
            }

            Button {
                appSheetCoordinatorStacked.presentSheet(.profile)
            } label: {
                Text("Go To Profile View Stacked Mode")
            }
        }
    }
}

#Preview {
    HomeView()
}
