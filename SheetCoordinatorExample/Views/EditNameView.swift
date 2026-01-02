//
//  EditNameView.swift
//  SheetCoordinatorExample
//
//  Created by Batuhan Ulutürk on 2.01.2026.
//

import SwiftUI

struct EditNameView: View {
    let paramater: NameAndEmailParamaters
    @EnvironmentObject var appSheetCoordinator: SheetCoordinator<AppSheet>

    var body: some View {
        bodyView
            .onAppear {
                print("Email: \(String(describing: paramater.email))")
                print("Name: \(String(describing: paramater.name))")
            }
    }

    var bodyView: some View {
        VStack(spacing: 8) {
            Text("Edit Name View")

            Button {
                appSheetCoordinator.popToPrevious()
            } label: {
                Text("Go To Back")
            }

            Button {
                appSheetCoordinator.onDismissAction = {
                    print("Sheet dismissed!")
                }
                appSheetCoordinator.sheetDismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

#Preview {
    EditNameView(
        paramater: .init()
    )
}
