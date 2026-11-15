import SwiftUI

struct ExploreView: View {
    @State private var selectedScene: ScenePhoto?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 24, pinnedViews: [.sectionHeaders]) {
                    heroStorySection

                    Section {
                        featuredCarousel
                    } header: {
                        pinnedHeader(title: "限定與主打風味", subtitle: "左右滑動翻頁探索 3% 輕盈口感")
                    }

                    Section {
                        moodStoriesScroll
                    } header: {
                        pinnedHeader(title: "微醺時刻 (Mood Stories)", subtitle: "點擊圓圈展開今晚的生活片刻")
                    }

                    Section {
                        pairingInspirationSection
                    } header: {
                        pinnedHeader(title: "今晚的下酒提案", subtitle: "超商與居酒屋的零負擔微醉搭餐")
                    }
                }
                .padding(.bottom, 28)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(hex: "#FCE4EC").opacity(0.28),
                        Color(.systemBackground),
                        Color(hex: "#E3F2FD").opacity(0.22)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationTitle("ほろよい 微醉手記")
            .sheet(item: $selectedScene) { scene in
                SceneStorySheet(scene: scene)
            }
        }
    }

    private var heroStorySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundStyle(Color(hex: "#E87A90"))
                    .symbolEffect(.pulse.byLayer, options: .repeat(.continuous))
                Text("SUNTORY HOROYOI · E-BOOK EDITION")
                    .font(.caption.weight(.semibold))
                    .tracking(1.1)
                    .foregroundStyle(.secondary)
            }

            combinedHeroHeadline
                .lineSpacing(6)

            Text("從「剛剛好」的 3% 酒精濃度出發，ほろよい 微醉將水果的清甜與細緻氣泡寫進日常傍晚。不追求濃烈醉意，而是替忙碌的一天畫下溫柔句點。")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineSpacing(5)

            HStack(spacing: 12) {
                Label("全系列 6 款人氣口味", systemImage: "drop.fill")
                Label("6 種微醺生活場景", systemImage: "camera.aperture")
            }
            .font(.caption.weight(.medium))
            .foregroundStyle(.secondary)
            .padding(.top, 2)
        }
        .horoyoiCardStyle()
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private var combinedHeroHeadline: Text {
        let abvSegment = Text("3%")
            .font(.system(.largeTitle, design: .rounded, weight: .heavy))
            .foregroundStyle(Color(hex: "#E87A90"))
            .underline(true, color: Color(hex: "#E87A90").opacity(0.65))
        let gentleSegment = Text(" 的溫柔微醺，\n")
            .font(.system(.title2, design: .serif, weight: .medium))
            .foregroundStyle(.primary)
        let nightSegment = Text("留給今晚的自己")
            .font(.system(.title2, design: .rounded, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    colors: [Color(hex: "#E87A90"), Color(hex: "#9575CD")],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        return Text("\(abvSegment)\(gentleSegment)\(nightSegment)")
    }

    private var featuredCarousel: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(HoroyoiData.flavors) { item in
                    NavigationLink(destination: FlavorDetailView(flavor: item)) {
                        carouselCard(for: item)
                    }
                    .buttonStyle(.plain)
                    .containerRelativeFrame(.horizontal)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
    }

    private func carouselCard(for item: FlavorItem) -> some View {
        let accent = Color(hex: item.accentColorHex)

        return HStack(spacing: 16) {
            HoroyoiAssetImage(
                assetName: item.imageName,
                accentColor: accent,
                fallbackSymbol: "wineglass.fill"
            )
            .frame(width: 118, height: 156)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Text(item.isSeasonal ? "期間限定" : "經典人氣")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(accent.opacity(0.16), in: Capsule())

                    Text("\(item.abv, specifier: "%.0f")%")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                }

                Text(item.name)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.primary)

                Text(item.jpName)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(item.tagline)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Spacer(minLength: 4)

                HStack(spacing: 4) {
                    Text("進入品味筆記")
                        .font(.caption.weight(.semibold))
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.caption)
                }
                .foregroundStyle(accent)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 176)
        .horoyoiCardStyle()
        .padding(.horizontal, 16)
    }

    private var moodStoriesScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(HoroyoiData.scenes) { scene in
                    Button {
                        selectedScene = scene
                    } label: {
                        VStack(spacing: 8) {
                            ZStack {
                                Circle()
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [
                                                Color(hex: "#F48FB1"),
                                                Color(hex: "#FF8A65"),
                                                Color(hex: "#9575CD")
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 3
                                    )
                                    .frame(width: 82, height: 82)

                                HoroyoiAssetImage(
                                    assetName: scene.imageName,
                                    accentColor: Color(hex: "#F48FB1"),
                                    fallbackSymbol: "photo.fill",
                                    contentMode: .fill,
                                    compact: true
                                )
                                .frame(width: 72, height: 72)
                                .clipShape(Circle())
                            }

                            Text(scene.moodTag)
                                .font(.caption.weight(.medium))
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        .frame(width: 86)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }

    private var pairingInspirationSection: some View {
        VStack(spacing: 12) {
            ForEach(HoroyoiData.pairings) { pairing in
                HStack(spacing: 14) {
                    Image(systemName: pairing.symbolName)
                        .font(.title3)
                        .foregroundStyle(Color(hex: "#E87A90"))
                        .frame(width: 44, height: 44)
                        .background(Color(hex: "#E87A90").opacity(0.14), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(pairing.name)
                                .font(.subheadline.weight(.bold))
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(pairing.category)
                                .font(.caption2.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(.ultraThinMaterial, in: Capsule())
                        }
                        Text(pairing.note)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineSpacing(3)
                    }
                }
                .horoyoiCardStyle(cornerRadius: 18, padding: 14)
            }
        }
        .padding(.horizontal, 16)
    }

    private func pinnedHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundStyle(.primary)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
}
