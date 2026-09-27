import SwiftUI
import WebKit

struct ProductView: View {
	private enum Constants {
		static var stackSpacing: CGFloat = 8
		static var estimatedImageHeight: CGFloat = 400
	}

	let viewModel: ProductViewModel

	var body: some View {
		ScrollView {
			Group() {
				if viewModel.isLoading {
					loadingView
				} else {
					loadedArtworkView(viewModel: viewModel)
				}
			}
			.padding()
			.task {
				await viewModel.getArtwork(id: "129884")
			}
		}
	}

	private func loadedArtworkView(viewModel: ProductViewModel) -> some View {
		VStack(alignment: .leading, spacing: Constants.stackSpacing) {
			if let imageURL = viewModel.imageURL {
				// Unfortunately the image API has a 2 factor authentication loader that I couldn't work around using AsyncImage, so it is displayed as a webView instead
				ImageWebView(url: imageURL)
					.accessibilityLabel(Text(viewModel.alternativeTextLabel))
					.accessibilityHint(Text(viewModel.alternativeTextHint))
			}
			if let title = viewModel.title {
				Text(title)
					.font(.title3)
			}
			if let artistDetails = viewModel.artistDetails {
				Text(artistDetails)
					.font(.caption)
					.foregroundStyle(.gray)
			}
			if let shortDescription = viewModel.shortDescription {
				Text(shortDescription)
					.font(.footnote)
			}
		}
	}

	private var loadingView: some View {
		VStack(alignment: .leading, spacing: Constants.stackSpacing) {
			Color.gray
				.frame(height: Constants.estimatedImageHeight)
				.frame(maxWidth: .infinity)
			Text(LoadingConstants.shortLoadingContent)
				.redacted(reason: .placeholder)
			Text(LoadingConstants.shortLoadingContent)
				.redacted(reason: .placeholder)
			Text(LoadingConstants.longLoadingContent)
				.redacted(reason: .placeholder)
		}
	}
}
