struct ArtworkList: Codable {
//	let pagination: Pagination
	let data: [ProductListArtworkData]
}

//struct Pagination: Codable {
//	let total: Double
//	let offset: Double
//	let total_Pages: Double
//	let current_Page: Double
//}

struct ProductListArtworkData: Codable {
	let id: Double
	let title: String
//	let artist_display: String
//	let description: String?
//	let short_description: String?
//	let thumbnail: Thumbnail?
	let image_id: String?
}
