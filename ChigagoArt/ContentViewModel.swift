import Observation

@Observable class ContentViewModel {
    private(set) var isLoading = false
    private(set) var artwork: ArtworkData?
    let networking: NetworkingServiceProtocol
    
    init(networking: NetworkingServiceProtocol) {
        self.networking = networking
    }
    
    @MainActor
    func getArtwork() async {
        isLoading = true
        artwork = try? await networking.getArtwork(id: "129884").data
    }
}
