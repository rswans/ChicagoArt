import SwiftUI

@main
struct ChigagoArtApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(networking: NetworkingService()))
        }
    }
}
