import SwiftUI
import WebKit

struct ImageWebView: View {
    var url: URL?
    
    var body: some View {
        if let url {
            WebView(url: url)
        } else {
            Color.yellow
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
