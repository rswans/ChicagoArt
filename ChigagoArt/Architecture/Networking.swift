import Foundation

protocol NetworkingServiceProtocol {
    func getArtwork(id: String) async throws -> Artwork
	func getArtworks(page: Int, limit: Int) async throws -> ArtworkList
}

final class NetworkingService: NetworkingServiceProtocol {
    func getArtwork(id: String) async throws -> Artwork {
		guard let url = URL(string: "https://api.artic.edu/api/v1/artworks/\(id)") else {
			print("invalid artwork URL")
			throw NetworkError.invalidURL
		}
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Artwork.self, from: data)
    }

	func getArtworks(page: Int, limit: Int) async throws -> ArtworkList {
		guard let url = URL(string: "https://api.artic.edu/api/v1/artworks")?
			.appending(queryItems: [URLQueryItem(name: "page", value: String(page)),
									URLQueryItem(name: "limit", value: String(limit)),] ) else {
			print("invalid artworksList URL")
			throw NetworkError.invalidURL
		}

		let (data, _) = try await URLSession.shared.data(from: url)
		return try JSONDecoder().decode(ArtworkList.self, from: data)
	}
}

enum NetworkError: Error {
    case invalidURL
}
