struct Artwork: Codable {
	let data: ArtworkData
	let config: ImageConfig
}

struct ArtworkData: Codable {
	let id: Double
	let title: String
	let artist_display: String
	let description: String
	let short_description: String
	let thumbnail: Thumbnail
	let image_id: String
}

struct ImageConfig: Codable {
	let iiif_url: String
	let website_url: String
}

struct Thumbnail: Codable {
	let lqip: String
	let width: Int
	let height: Int
	let alt_text: String
}
