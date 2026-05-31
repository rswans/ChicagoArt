import Foundation

protocol NetworkingServiceProtocol {
    func getArtwork(id: String) async throws -> Artwork
}

final class NetworkingService: NetworkingServiceProtocol {
    func getArtwork(id: String) async throws -> Artwork {
        let filteredfields = "id, title,artist_display,description,short_description,thumbnail"
        guard let url = URL(string: "https://api.artic.edu/api/v1/artworks/\(id)") else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Artwork.self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
}

struct Artwork: Codable {
    let data: ArtworkData
}

struct ArtworkData: Codable {
    let id: Double
    let title: String
    let artist_display: String
    let description: String
    let short_description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let lqip: String
    let width: Int
    let height: Int
    let alt_text: String
}
