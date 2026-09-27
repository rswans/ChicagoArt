import SwiftUI
import WebKit

struct ContentView: View {
	let productViewModel: ProductViewModel

    var body: some View {
        ProductView(viewModel: productViewModel)
    }
}
