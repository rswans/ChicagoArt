@testable import ChigagoArt

final class MockNetworking: NetworkingServiceProtocol {
	var forcedArtwork: Artwork = Artwork(data: .stub(),
										 config: .stub())

	private(set) var getArtworkCalledCount = 0
	private(set) var artworkID: String?

	func getArtwork(id: String) async throws -> Artwork {
		getArtworkCalledCount += 1
		artworkID = id

		return forcedArtwork
	}
}

extension ArtworkData {
	static func stub(id: Double = 12345,
					 title: String = "Cat",
					 artist_display: String = "Bob Stevenson",
					 description: String = "A particularly good drawing of a cat",
					 short_description: String = "A drawing of a cat",
					 thumbnail: Thumbnail = .stub(),
					 image_id: String = "54321" ) -> ArtworkData {
		ArtworkData(id: id,
					title: title,
					artist_display: artist_display,
					description: description,
					short_description: short_description,
					thumbnail: thumbnail,
					image_id: image_id)
	}
}

extension ImageConfig {
	static func stub(iiif_url: String = "iiif_url",
					 website_url: String = "website_url") -> ImageConfig {
		ImageConfig(iiif_url: iiif_url,
					website_url: website_url)
	}
}

extension Thumbnail {
	static func stub(lqip: String = "lqip",
					 width: Int = 20,
					 height: Int = 30,
					 alt_text: String = "alt text") -> Thumbnail {
		Thumbnail(lqip: lqip,
				  width: width,
				  height: height,
				  alt_text: alt_text)
	}
}
