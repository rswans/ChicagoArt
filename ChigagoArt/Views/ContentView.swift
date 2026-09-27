import SwiftUI
import WebKit

struct ContentView: View {
	let productListViewModel: ProductListViewModel

    var body: some View {
        ProductListView(viewModel: productListViewModel)
    }
}
