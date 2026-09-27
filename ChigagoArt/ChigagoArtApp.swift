import SwiftUI

@main
struct ChigagoArtApp: App {
    var body: some Scene {
        WindowGroup {
			ContentView(productViewModel: ProductViewModel(artworkID: "129884",
														   networking: NetworkingService()))
        }
    }
}
