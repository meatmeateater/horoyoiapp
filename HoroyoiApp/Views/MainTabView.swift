import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("微醉故事", systemImage: "sparkles.rectangle.stack") {
                ExploreView()
            }
            Tab("風味圖鑑", systemImage: "list.bullet.indent") {
                FlavorListView()
            }
            Tab("微醺劇場", systemImage: "photo.on.rectangle.angled") {
                GalleryAndMediaView()
            }
            Tab("官方網站", systemImage: "safari") {
                BrandWebView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}
