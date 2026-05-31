import SwiftUI
import WebKit

struct ContentView: View {
    let viewModel: ContentViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if viewModel.isLoading {
                    loadingView
                } else {
                    loadedArtworkView(viewModel: viewModel)
                }
            }
            .padding()
            .task {
                await viewModel.getArtwork()
            }
        }
    }
    
    private func loadedArtworkView(viewModel: ContentViewModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = viewModel.imageURL {
                // Unfortunately the image API has a loader that I couldn't work around using AsyncImage, so it is displayed as a webView instead
                ImageWebView(url: imageURL)
                    .frame(height: 400)
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
    
    private var loadingView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Color.gray
                .frame(height: 400)
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
