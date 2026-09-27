import XCTest
@testable import ChigagoArt

final class ProductViewModelTests: XCTestCase {
	private var mockNetworking: MockNetworking!

	override func setUp() {
		super.setUp()

		mockNetworking = MockNetworking()
	}

	@MainActor
	func test_networking_returnsExpectedArtwork() async {
		let productViewModel = ProductViewModel(networking: mockNetworking)

		await productViewModel.getArtwork(id: "12345678")
		XCTAssertEqual(productViewModel.title, "Cat")
		XCTAssertEqual(productViewModel.description, "A particularly good drawing of a cat")
		XCTAssertEqual(productViewModel.alternativeTextHint, "alt text")
		XCTAssertEqual(productViewModel.alternativeTextLabel, "An image of the painting")
		XCTAssertFalse(productViewModel.isLoading)
    }
}
