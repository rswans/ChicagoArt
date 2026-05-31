import Foundation
import Observation

@Observable final class ContentViewModel {
    enum Constants {
        static let alternativeTextLabel = "An image of the painting"
        static let noTextHintAvailable = "Sorry, alternative text was not provided for this image"
    }
    
    // MARK: Private Properties
    private let networking: NetworkingServiceProtocol
    
    // MARK: Internal Properties
    private(set) var isLoading = false
    private(set) var artwork: ArtworkData?
    
    var alternativeTextHint: String {
        artwork?.thumbnail.alt_text ?? Constants.noTextHintAvailable
    }
    
    var alternativeTextLabel: String {
        Constants.alternativeTextLabel
    }
    
    var imageURL: URL? {
        URL(string: "https://www.artic.edu/iiif/2/\(artwork?.image_id ?? "")/full/843,/0/default.jpg")
    }
    
    // MARK: Initialisers
    init(networking: NetworkingServiceProtocol) {
        self.networking = networking
    }
    
    // MARK: Public Properties
    @MainActor
    func getArtwork() async {
        isLoading = true
        artwork = try? await networking.getArtwork(id: "129884").data
        isLoading = false
    }
}
