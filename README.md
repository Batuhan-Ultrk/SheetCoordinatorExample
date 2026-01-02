📄 SheetCoordinatorExample – Advanced Sheet & Navigation Management for SwiftUI

Bu proje, SwiftUI’da sheet yönetimini daha modüler, tekrar kullanılabilir ve navigation destekli hale getirmek için tasarlanmış bir mimari örneğidir.
SwiftUI’nın .sheet yapısının sınırlamalarını aşarak stacked ve embedded olmak üzere iki farklı çalışma moduyla güçlü bir sheet akışı sağlar.
🚀 Özellikler
Sheet Coordinator Pattern
NavigationStack destekli sheet navigation (embedded mode)
Basit sheet sunumu (stacked mode)
Reusable sheetHost modifier
Dismiss + Pop yetenekleri
OnDismiss callback desteği
Sub Coordinator oluşturma
Custom detents, drag indicator ve dismiss behavior desteği

⚙️ SheetCoordinator
SwiftUI içinde sheet akışını yönetmek için kullanılan merkezi kontrol yapısıdır.
```md
```swift
final class SheetCoordinator<Sheet: SheetEnum>: ObservableObject {
    @Published var currentSheet: Sheet?
    @Published var navigationPath = NavigationPath()

    let presentationMode: SheetPresentationMode
    var onDismissAction: (() -> Void)?

    init(mode: SheetPresentationMode) {
        self.presentationMode = mode
    }

    @MainActor
    func presentSheet(_ sheet: Sheet) { ... }

    @MainActor
    func onDismiss() { ... }

    @MainActor
    func sheetDismiss() { ... }

    @MainActor
    func popToPrevious() { ... }
}
```
🎛 Presentation Modes
Mode	Açıklama
stacked	Her sheet kendi başına açılır. Navigation yoktur.
embedded	Sheet içinde NavigationStack destekler. İç içe sheet akışları sağlar.
🧩 SheetHost
Coordinator için SwiftUI sheet katmanını yöneten view.
```md
```swift
struct SheetHost<Sheet: SheetEnum>: View {
    @ObservedObject var coordinator: SheetCoordinator<Sheet>

    var body: some View {
        Color.clear
            .sheet(
                item: $coordinator.currentSheet,
                onDismiss: { coordinator.onDismiss() }
            ) { sheet in
                buildSheetContent(sheet: sheet)
                    .applySheetModifiers(for: sheet)
            }
    }
}
```
🧱 View Extension
```md
```swift
extension View {
    func sheetHost<Sheet: SheetEnum>(_ coordinator: SheetCoordinator<Sheet>) -> some View {
        self.overlay(
            SheetHost(coordinator: coordinator)
                .allowsHitTesting(false)
        )
    }
}
```
🧭 AppSheet Enum
```md
```swift
enum AppSheet: SheetEnum, Identifiable {
    case profile
    case settings
    case editName

    var id: String { String(describing: self) }

    @ViewBuilder
    func view(coordinator: SheetCoordinator<AppSheet>) -> some View {
        switch self {
        case .profile: ProfileView().environmentObject(coordinator)
        case .settings: SettingsView().environmentObject(coordinator)
        case .editName: EditNameView().environmentObject(coordinator)
        }
    }
}
```
🎯 Sonuç
SheetCoordinator, SwiftUI projelerinde karmaşık sheet akışlarını sadeleştiren, modüler hale getiren ve navigation destekleyen güçlü bir çözüm sağlar.
Navigation
Dismiss yönetimi
Nested sheet flows
Daha temiz bir View mimarisi
için ideal bir çözümdür.
