import Foundation
final class ProductListArtworkViewModel {
	enum Constants {
		static let alternativeTextLabel = "An image of the painting"
	}

	let artwork: ProductListArtworkData

	var title: String {
		artwork.title
	}

	var imageURL: URL? {
		URL(string: "https://www.artic.edu/iiif/2/\(artwork.image_id)/full/843,/0/default.jpg")
	}

	var alternativeTextHint: String {
		/*artwork.thumbnail?.alt_text ??*/ ""
	}

	var alternativeTextLabel: String {
		Constants.alternativeTextLabel
	}

	init(artwork: ProductListArtworkData) {
		self.artwork = artwork
	}
}
