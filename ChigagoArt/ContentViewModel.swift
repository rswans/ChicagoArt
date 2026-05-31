import Foundation
import Observation
internal import UIKit

@Observable final class ContentViewModel {
    enum Constants {
        static let alternativeTextLabel = "An image of the painting"
        static let noTextHintAvailable = "Sorry, alternative text was not provided for this image"
    }
    
    // MARK: Private Properties
    private let networking: NetworkingServiceProtocol
    
    // MARK: Internal Properties
    private(set) var isLoading = false
    private var artwork: ArtworkData?
    private var imageConfig: ImageConfig?
    
    var alternativeTextHint: String {
        artwork?.thumbnail.alt_text ?? Constants.noTextHintAvailable
    }
    
    var alternativeTextLabel: String {
        Constants.alternativeTextLabel
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
    
    var imageURL: URL? {
        URL(string: "\(imageConfig?.iiif_url ?? "")/\(artwork?.image_id ?? "")/full/843,/0/default.jpg")
    }
    
    // MARK: Initialisers
    init(networking: NetworkingServiceProtocol) {
        self.networking = networking
    }
    
    // MARK: Public Properties
    @MainActor
    func getArtwork() async {
        isLoading = true
        guard let data = try? await networking.getArtwork(id: "129884") else { return }
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
