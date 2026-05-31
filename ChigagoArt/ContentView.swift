import SwiftUI

struct ContentView: View {
    let viewModel: ContentViewModel
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(viewModel.artwork?.short_description ?? "")
        }
        .padding()
        .task {
            await viewModel.getArtwork()
        }
    }
}
