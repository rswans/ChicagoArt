import SwiftUI

@main
struct ChigagoArtApp: App {
    var body: some Scene {
        WindowGroup {
			ContentView(productListViewModel: ProductListViewModel(networking: NetworkingService()))
        }
    }
}
