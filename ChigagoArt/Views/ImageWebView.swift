import SwiftUI
import WebKit

struct ImageWebView: View {
	var url: URL?

	@State private var webViewHeight: CGFloat = .zero

    var body: some View {
        if let url {
			WebView(url: url, dynamicHeight: $webViewHeight)
				.frame(height: webViewHeight)
        } else {
            Color.yellow
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
	@Binding var dynamicHeight: CGFloat

	private enum Constants {
		static let contentSizeKeyPath = "contentSize"
	}

    func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
		webView.scrollView.isScrollEnabled = false
		webView.scrollView.addObserver(context.coordinator, forKeyPath: Constants.contentSizeKeyPath, options: .new, context: nil)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }

	static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
		uiView.scrollView.removeObserver(coordinator, forKeyPath: Constants.contentSizeKeyPath)
		}

		func makeCoordinator() -> Coordinator {
			Coordinator(height: $dynamicHeight)
		}

		class Coordinator: NSObject, WKNavigationDelegate {
			var height: Binding<CGFloat>

			init(height: Binding<CGFloat>) {
				self.height = height
			}

			// Handle KVO (Key-Value Observing) changes for the content size
			override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
				if keyPath == Constants.contentSizeKeyPath, let scrollView = object as? UIScrollView {
					DispatchQueue.main.async {
						// Update the SwiftUI binding with the actual height of the HTML content
						self.height.wrappedValue = scrollView.contentSize.height
					}
				}
			}
		}
}
