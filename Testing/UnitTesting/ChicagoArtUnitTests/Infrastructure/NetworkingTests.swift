import XCTest
@testable import ChigagoArt

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
