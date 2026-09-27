import SwiftUI

struct ArtworkView: View {
	let viewModel: ProductViewModel

	private enum Constants {
		static let stackViewSpacing: CGFloat = 8
		static let imageHeight: CGFloat = 400
	}

	var body: some View {
		VStack(alignment: .leading, spacing: Constants.stackViewSpacing) {
			if let imageURL = viewModel.imageURL {
				// Unfortunately the image API has a loader that I couldn't work around using AsyncImage, so it is displayed as a webView instead
				ImageWebView(url: imageURL)
					.frame(height: Constants.imageHeight)
					.accessibilityLabel(Text(viewModel.alternativeTextLabel))
					.accessibilityHint(Text(viewModel.alternativeTextHint))
			}
			if let title = viewModel.title {
				Text(title)
					.font(.title)
			}
			if let artistDetails = viewModel.artistDetails {
				Text(artistDetails)
					.font(.caption)
					.foregroundStyle(.gray)
			}
			if let description = viewModel.description {
				Text(description)
					.font(.body)
			}
		}
	}
}
