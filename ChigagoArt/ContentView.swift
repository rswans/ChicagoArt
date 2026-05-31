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
                    .accessibilityLabel(Text("An image of the painting"))
                    .accessibilityHint(Text(viewModel.alternativeTextHint))
            }
            Text(viewModel.artwork?.artist_display ?? "")
            Text(viewModel.artwork?.description ?? "")
        }
    }
    
    private var loadingView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Color.gray
                .frame(height: 400)
                .frame(maxWidth: .infinity)
            Text(LoadingConstants.shortLoadingContent)
                .redacted(reason: .placeholder)
            Text(LoadingConstants.longLoadingContent)
                .redacted(reason: .placeholder)
        }
    }
}
