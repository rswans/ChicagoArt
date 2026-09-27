@testable import ChigagoArt
import SnapshotTesting
import XCTest
internal import SwiftUI

final class ProductViewSnapshotTests: XCTestCase {

	func test_productView_loading() {
		let viewModel = ProductViewModel(artworkID: "12345678",
										 networking: MockNetworking())
		let view = ProductView(viewModel: viewModel)
			.frame(width: .iPhone17Width, height: .iPhone17Height)


		assertSnapshot(of: view, as: .image(precision: 0.98,
											traits: .init(displayGamut: .SRGB)))
	}

	@MainActor
	func test_productView_loaded() async {
		let viewModel = ProductViewModel(artworkID: "12345678",
										 networking: MockNetworking())
		await viewModel.getArtwork()
		let view = ProductView(viewModel: viewModel)
			.frame(width: .iPhone17Width, height: .iPhone17Height)


		assertSnapshot(of: view, as: .image(precision: 0.98,
											traits: .init(displayGamut: .SRGB)))
	}

	@MainActor
	func test_productView_loaded_longContent() async {
		let mockNetworking = MockNetworking()
		mockNetworking.forcedArtwork = Artwork.stub(data: .stub(title: LoadingConstants.longLoadingContent,
																artist_display: LoadingConstants.longLoadingContent,
																short_description: LoadingConstants.longLoadingContent))
		let viewModel = ProductViewModel(artworkID: "12345678",
										 networking: mockNetworking)
		await viewModel.getArtwork()
		let view = ProductView(viewModel: viewModel)
			.frame(width: .iPhone17Width, height: .iPhone17Height)


		assertSnapshot(of: view, as: .image(precision: 0.98,
											traits: .init(displayGamut: .SRGB)))
	}
}

extension CGFloat {
	static var iPhone17Width: CGFloat {
		440
	}

	static var iPhone17Height: CGFloat {
		956
	}
}
