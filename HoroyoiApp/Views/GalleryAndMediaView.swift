import AVKit
import SwiftUI

struct GalleryAndMediaView: View {
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    @State private var player: AVPlayer?
    @State private var selectedScene: ScenePhoto?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    videoSection
                    photoWallSection
                    remoteBannerSection
                }
                .padding()
            }
            .navigationTitle("微醺寫真與影音")
            .onAppear {
                prepareVideoPlayerIfNeeded()
            }
            .onDisappear {
                player?.pause()
            }
            .sheet(item: $selectedScene) { scene in
                SceneStorySheet(scene: scene)
            }
        }
    }

    private var videoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeading(title: "品牌形象微電影", systemImage: "film.stack")

            if let player {
                VideoPlayer(player: player)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .horoyoiCardStyle(cornerRadius: 22, padding: 10)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.system(size: 42))
                        .foregroundStyle(Color(hex: "#E87A90"))
                        .symbolEffect(.pulse.byLayer, options: .repeat(.continuous))

                    Text("品牌廣告影片預留位置")
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text("請將 horoyoi_cm.mp4 加入 HoroyoiApp/Resources/ 或專案目標資源中，即可直接在此播放微醉形象短片。")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 190)
                .horoyoiCardStyle()
            }
        }
    }

    private var photoWallSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeading(title: "微醺寫真牆", systemImage: "photo.on.rectangle.angled")

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(HoroyoiData.scenes) { scene in
                    Button {
                        selectedScene = scene
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            HoroyoiAssetImage(
                                assetName: scene.imageName,
                                accentColor: Color(hex: "#F48FB1"),
                                fallbackSymbol: "camera.macro",
                                contentMode: .fill
                            )
                            .frame(height: 136)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(scene.moodTag)
                                    .font(.caption2.weight(.bold))
                                    .foregroundStyle(Color(hex: "#E87A90"))

                                Text(scene.title)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)
                            }
                        }
                        .horoyoiCardStyle(cornerRadius: 18, padding: 10)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var remoteBannerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeading(title: "官方線上視覺畫報", systemImage: "network")

            VStack(spacing: 14) {
                ForEach(Array(HoroyoiData.remoteBannerURLs.enumerated()), id: \.element) { index, url in
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                VStack(spacing: 8) {
                                    ProgressView()
                                    Text("載入官方視覺 \(index + 1)...")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(height: 170)

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 170)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                        case .failure:
                            ZStack {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color(.secondarySystemBackground))
                                VStack(spacing: 8) {
                                    Image(systemName: "wifi.exclamationmark")
                                        .font(.title2)
                                        .foregroundStyle(.secondary)
                                    Text("無法載入遠端圖片（請確認網路連線）")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(height: 170)

                        @unknown default:
                            EmptyView()
                        }
                    }
                    .horoyoiCardStyle(cornerRadius: 20, padding: 10)
                }
            }
        }
    }

    private func sectionHeading(title: String, systemImage: String) -> some View {
        Label(title, systemImage: systemImage)
            .font(.title3.weight(.bold))
            .foregroundStyle(.primary)
    }

    private func prepareVideoPlayerIfNeeded() {
        guard player == nil,
              let videoURL = Bundle.main.url(forResource: "horoyoi_cm", withExtension: "mp4") else {
            return
        }
        player = AVPlayer(url: videoURL)
    }
}
