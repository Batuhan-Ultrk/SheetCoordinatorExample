//
//  SheetCoordinator.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 15.05.2025.
//

import SwiftUI

final class SheetCoordinator<Sheet: SheetEnum>: ObservableObject {
    @Published var currentSheet: Sheet?
    @Published var navigationPath = NavigationPath()
    
    let presentationMode: SheetPresentationMode
    var onDismissAction: (() -> Void)?
    
    init(mode: SheetPresentationMode) {
        self.presentationMode = mode
    }

    @MainActor
    func presentSheet(_ sheet: Sheet) {
        switch presentationMode {
        case .stacked:
            guard currentSheet != sheet else { return }
            currentSheet = sheet
        case .embedded:
            if currentSheet == nil {
                currentSheet = sheet
            } else {
                navigationPath.append(sheet)
            }  
        }
    }

    @MainActor
    func onDismiss() {
        switch presentationMode {
        case .stacked:
            currentSheet = nil
        case .embedded:
            navigationPath.removeLast(navigationPath.count)
            currentSheet = nil
        }
    }

    @MainActor
    func sheetDismiss() {
        switch presentationMode {
        case .stacked:
            currentSheet = nil
        case .embedded:
            navigationPath.removeLast(navigationPath.count)
            currentSheet = nil
        }

        onDismissAction?()
    }

    @MainActor
    func popToPrevious() {
        switch presentationMode {
        case .stacked:
            currentSheet = nil
        case .embedded:
            if navigationPath.count > 0 {
                navigationPath.removeLast()
            } else {
                currentSheet = nil
            }
        }
    }
}

extension SheetCoordinator {
    func makeSubCoordinator<Sub: SheetEnum>(embed: Sub) -> SheetCoordinator<Sub> {
        SheetCoordinator<Sub>(mode: self.presentationMode)
    }
}
