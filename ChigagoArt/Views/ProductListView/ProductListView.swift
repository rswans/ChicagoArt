import SwiftUI

struct ProductListView: View {
	var viewModel: ProductListViewModel

	var body: some View {
		ScrollView {
			VStack {
				ProductListHeaderView(title: viewModel.title)
				ProductListGrid(viewModel: viewModel)
			}
		}
		.task {
			await viewModel.fetchArtworkList(page: 1)
		}
	}
}

struct ProductListHeaderView: View {
	let title: String

	var body: some View {
		Text(title)
			.font(.largeTitle)
	}
}

struct ProductListGrid: View {
	var viewModel: ProductListViewModel

	private let layout = [
		GridItem(.flexible(minimum: 50, maximum: .infinity)),
		GridItem(.flexible(minimum: 50, maximum: .infinity))
	]

	var body: some View {
		LazyVGrid(
			columns: layout,
			alignment: .center,
			spacing: 8
		) {
			ForEach(viewModel.artworks.enumerated(), id: \.offset) { index, element in
				ProductListArtworkView(viewModel: ProductListArtworkViewModel(artwork: element))
			}
		}
	}
}
