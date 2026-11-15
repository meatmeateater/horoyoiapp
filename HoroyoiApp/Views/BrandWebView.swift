import SwiftUI
import WebKit

struct BrandWebView: View {
    private let officialURL = HoroyoiData.officialWebsiteURL

    var body: some View {
        NavigationStack {
            WebView(url: officialURL)
                .webViewBackForwardNavigationGestures(.enabled)
                .navigationTitle("三得利微醉官網")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Link(destination: officialURL) {
                            Label("於 Safari 開啟", systemImage: "arrow.up.right.square")
                        }
                    }
                }
        }
    }
}
