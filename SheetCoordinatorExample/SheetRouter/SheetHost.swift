//
//  SheetHost.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 21.05.2025.
//

import SwiftUI

struct SheetHost<Sheet: SheetEnum>: View {
    @ObservedObject var coordinator: SheetCoordinator<Sheet>

    var body: some View {
        Color.clear
            .sheet(
                item: $coordinator.currentSheet,
                onDismiss: {
                    if coordinator.presentationMode == .embedded {
                        coordinator.onDismiss()
                    }
                },
                content: { sheet in
                    buildSheetContent(sheet: sheet)
                        .applySheetModifiers(for: sheet)
                }
            )
    }

    @ViewBuilder
    private func buildSheetContent(sheet: Sheet) -> some View {
        switch coordinator.presentationMode {
        case .embedded:
            NavigationStack(path: $coordinator.navigationPath) {
                sheet.view(coordinator: coordinator)
                    .environmentObject(coordinator)
                    .navigationDestination(for: Sheet.self) { next in
                        next.view(coordinator: coordinator)
                            .environmentObject(coordinator)
                    }
            }
        case .stacked:
            sheet.view(coordinator: coordinator)
                .environmentObject(coordinator)
        }
    }
}

extension View {
    func applySheetModifiers(for sheet: any SheetEnum) -> some View {
        self
            .presentationDetents(sheet.presentationDetents)
            .presentationDragIndicator(sheet.presentationDragIndicator)
            .interactiveDismissDisabled(sheet.interactiveDismissDisabled)
    }

    func sheetHost<Sheet: SheetEnum>(_ coordinator: SheetCoordinator<Sheet>) -> some View {
        self.overlay(
            SheetHost(coordinator: coordinator)
                .allowsHitTesting(false)
        )
    }
}
