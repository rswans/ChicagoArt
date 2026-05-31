import XCTest
@testable import ChigagoArt

final class NetworkingTests: XCTestCase {
    func test_networking_returnsArtwork() throws {
        let expectation = expectation(description: "Fetches from network")
        let networking = NetworkingService()
        Task {
            let artwork = try await networking.getArtwork(id: "129884")
            XCTAssertEqual(artwork, Artwork(data: ArtworkData(id: 129884,
                                                              title: "Stary Night and the Astronauts",
                                                              artist_display: "Alma Thomas\nAmerica, 1891-1978",
                                                              description: "\\u003Cp\\u003EAfter decades as a representational painter, in her seventies Alma Thomas turned to abstraction, creating shimmering, mosaic-like fields of color with rhythmic dabs of paint that were often inspired by forms from nature. The artist had been fascinated with space exploration since the late 1960s, and her later paintings often referenced America’s manned Apollo missions to the moon. Although she had never flown, Thomas began to paint as if she were in an airplane, capturing what she described as shifting patterns of light and streaks of color. “You look down on things,” she explained. “You streak through the clouds so fast. . . . You see only streaks of color.”\\u003C/p\\u003E\n\\u003Cp\\u003E\\u003Cem\\u003EStarry Night and the Astronauts\\u003C/em\\u003E evokes the open expanse and celestial patterns of a night sky, but despite its narrative title, the work could also be read as an aerial view of a watery surface, playing with our sense of immersion within an otherwise flat picture plane. The viewer is immersed not only in the sense of organic expanse that this painting achieves, however, but also in an encounter with Thomas’s process: the surface here is clearly constructed stroke by stroke. Meanwhile, the glimpses of raw canvas between each primary-colored mark seem as vivid as the applied paint itself—almost as if the composition were backlit. Thomas relied on the enlivening properties of color throughout her late-blooming career. “Color is life,” she once proclaimed, “and light is the mother of color.” This painting was created in 1972, when the artist was eighty. In the same year, she became the first African American woman to receive a solo exhibition at a major art museum, the Whitney Museum of American Art in New York City.\\u003C/p\\u003E\n",
                                                              short_description: "Alma Thomas was enthralled by astronauts and outer space. This painting, made when she was 81, showcases that fascination through her signature style of short, rhythmic strokes of paint. “Color is life, and light is the mother of color,” she once proclaimed. In 1972, she became the first African American woman to have a solo exhibition at the Whitney Museum of American Art in New York.",
                                                              thumbnail: Thumbnail(lqip: "data:image/gif;base64,R0lGODlhBAAFAPQAABw/Zhg/aBRBaBZBahRCaxxBahxEahNIchZJcR9LdB9OdiZIZSBEbShLbjxRZyBPeipRcSpReUpWaitXgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAAEAAUAAAURoMJIDhJAywAcAlEkxhNNTQgAOw==",
                                                                                   width: 5376,
                                                                                   height: 6112,
                                                                                   alt_text: "Abstract painting composed of small vertical dabs of multiple shades of blue with a small area of similar strokes of red, orange, and yellow in the upper right."))))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
}

extension Artwork: @retroactive Equatable {
    public static func == (lhs: Artwork, rhs: Artwork) -> Bool {
        lhs.data.artist_display == rhs.data.artist_display &&
        lhs.data.description == rhs.data.description &&
        lhs.data.id == rhs.data.id &&
        lhs.data.short_description == rhs.data.short_description &&
        lhs.data.thumbnail == rhs.data.thumbnail &&
        lhs.data.title == rhs.data.title
    }
}

extension Thumbnail: @retroactive Equatable {
    public static func == (lhs: Thumbnail, rhs: Thumbnail) -> Bool {
        lhs.alt_text == rhs.alt_text &&
        lhs.height == rhs.height &&
        lhs.width == rhs.width &&
        lhs.lqip == rhs.lqip
    }
}
