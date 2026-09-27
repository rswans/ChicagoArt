import Observation

@Observable
final class ProductListViewModel {

	enum Constants {
		static let pageLimit: Int = 100
	}

	var title: String = ""
	var artworks: [ProductListArtworkData] = []

	private let networking: NetworkingServiceProtocol

	init(networking: NetworkingServiceProtocol) {
		self.networking = networking
	}

	func fetchArtworkList(page: Int) async {
		guard let artworkList = try? await networking.getArtworks(page: page,
																  limit: Constants.pageLimit) else {
			print("error getting artworkList")
			return
		}
		artworks.append(contentsOf: artworkList.data.compactMap { $0 })
	}
}
