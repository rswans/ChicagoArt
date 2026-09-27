import SwiftUI
struct ProductListArtworkView: View {
	
	var viewModel: ProductListArtworkViewModel

	var body: some View {
		VStack {
				// Unfortunately the image API has a 2 factor authentication loader that I couldn't work around using AsyncImage, so it is displayed as a webView instead
			ImageWebView(url: viewModel.imageURL)
				.accessibilityLabel(Text(viewModel.alternativeTextLabel))
				.accessibilityHint(Text(viewModel.alternativeTextHint))
				.frame(maxHeight: 200)
			Text(viewModel.title)
				.font(.title3)
		}
	}
}
