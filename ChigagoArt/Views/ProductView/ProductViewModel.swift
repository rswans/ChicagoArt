import Foundation
import Observation
internal import UIKit

@Observable final class ProductViewModel {
    enum Constants {
        static let alternativeTextLabel = "An image of the painting"
        static let noTextHintAvailable = "Sorry, alternative text was not provided for this image"
    }
    
    // MARK: Private Properties
	private let networking: NetworkingServiceProtocol
	private var artwork: ArtworkData?
	private var imageConfig: ImageConfig?

	let artworkID: String

    // MARK: Internal Properties

    private(set) var isLoading = true

    var alternativeTextHint: String {
        return artwork?.thumbnail.alt_text ?? Constants.noTextHintAvailable
    }
    
    var alternativeTextLabel: String {
        return Constants.alternativeTextLabel
    }
   
    var title: String? {
        artwork?.title
    }
    
    var artistDetails: String? {
        artwork?.artist_display
    }
    
    var description: String? {
        artwork?.description.decoded
    }

	var shortDescription: String? {
		artwork?.short_description
	}

    var imageURL: URL? {
        URL(string: "\(imageConfig?.iiif_url ?? "")/\(artwork?.image_id ?? "")/full/843,/0/default.jpg")
    }
    
    // MARK: Initialisers
	init(artworkID: String,
		networking: NetworkingServiceProtocol) {
		self.artworkID = artworkID
        self.networking = networking
    }
    
    // MARK: Public Properties
    @MainActor
	func getArtwork() async {
        guard let data = try? await networking.getArtwork(id: artworkID) else { return }
        self.artwork = data.data
        imageConfig = data.config
        isLoading = false
    }
}

extension String {
    var decoded: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
        
        return attr?.string ?? self
    }
}
