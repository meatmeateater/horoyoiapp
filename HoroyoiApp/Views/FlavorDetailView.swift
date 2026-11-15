import SwiftUI

struct FlavorDetailView: View {
    let flavor: FlavorItem

    private enum MoodFilterPreset: String, CaseIterable, Identifiable {
        case original = "原色微醺"
        case sunset = "夕陽微光"
        case twilight = "夜色霓虹"
        case mint = "清晨露氣"

        var id: String { rawValue }

        var hueDegrees: Double {
            switch self {
            case .original: 0
            case .sunset: -28
            case .twilight: 68
            case .mint: 145
            }
        }

        var saturation: Double {
            switch self {
            case .original: 1.0
            case .sunset: 1.35
            case .twilight: 1.45
            case .mint: 0.85
            }
        }
    }

    @State private var isFloating = false
    @State private var isLiked = false
    @State private var cheersCount = 0
    @State private var showNotes = false
    @State private var selectedPreset: MoodFilterPreset = .original
    @State private var filterHue: Double = 0
    @State private var filterSaturation: Double = 1.0

    private var accentColor: Color {
        Color(hex: flavor.accentColorHex)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                heroShowcaseCard
                moodFilterCard
                tastingNotesSection
            }
            .padding(.horizontal)
            .padding(.vertical, 16)
        }
        .background(adaptiveBackgroundGradient.ignoresSafeArea())
        .navigationTitle(flavor.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isLiked.toggle()
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(isLiked ? .pink : .primary)
                        .symbolEffect(.bounce, value: isLiked)
                }
                .accessibilityLabel(isLiked ? "取消收藏" : "收藏此風味")
            }
        }
        .onAppear {
            isFloating = true
        }
    }

    private var adaptiveBackgroundGradient: some View {
        LinearGradient(
            colors: [
                accentColor.opacity(0.20),
                Color(.systemBackground),
                accentColor.opacity(0.08)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var heroShowcaseCard: some View {
        VStack(spacing: 18) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundStyle(accentColor)
                        .symbolEffect(.pulse.byLayer, options: .repeat(.continuous))
                    Text(flavor.isSeasonal ? "期間限定" : "經典常態")
                        .font(.caption.weight(.semibold))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(accentColor.opacity(0.16), in: Capsule())

                Spacer()

                Text("ALC. \(flavor.abv, specifier: "%.0f")%")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial, in: Capsule())
            }

            HoroyoiAssetImage(
                assetName: flavor.imageName,
                accentColor: accentColor,
                fallbackSymbol: "wineglass.fill"
            )
            .frame(maxWidth: 240, minHeight: 240, maxHeight: 260)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .hueRotation(.degrees(filterHue))
            .saturation(filterSaturation)
            .contrast(1.1)
            .shadow(color: accentColor.opacity(0.42), radius: 12, x: 0, y: 8)
            .offset(y: isFloating ? -10 : 6)
            .scaleEffect(isFloating ? 1.03 : 0.98)
            .animation(
                .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                value: isFloating
            )

            VStack(spacing: 6) {
                Text(flavor.jpName)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                Text(flavor.tagline)
                    .font(.title3.weight(.bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.primary)

                Text(flavor.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.top, 4)
            }

            HStack(spacing: 12) {
                Button {
                    isLiked.toggle()
                } label: {
                    Label(isLiked ? "已加入微醉最愛" : "收藏此風味", systemImage: "heart.fill")
                        .font(.subheadline.weight(.semibold))
                        .symbolEffect(.bounce, value: isLiked)
                }
                .buttonStyle(.borderedProminent)
                .tint(isLiked ? .pink : accentColor)

                Button {
                    cheersCount += 1
                } label: {
                    Label(cheersCount == 0 ? "乾杯" : "乾杯 \(cheersCount)", systemImage: "wineglass.fill")
                        .font(.subheadline.weight(.semibold))
                        .symbolEffect(.bounce, value: cheersCount)
                }
                .buttonStyle(.bordered)
                .tint(accentColor)
            }
        }
        .horoyoiCardStyle()
    }

    private var moodFilterCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("切換微醺濾鏡 (Mood Filter)", systemImage: "camera.filters")
                    .font(.headline)
                Spacer()
                Button("重設") {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedPreset = .original
                        filterHue = 0
                        filterSaturation = 1.0
                    }
                }
                .font(.caption.weight(.semibold))
            }

            Picker("微醺濾鏡", selection: $selectedPreset) {
                ForEach(MoodFilterPreset.allCases) { preset in
                    Text(preset.rawValue).tag(preset)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedPreset) { _, newValue in
                withAnimation(.easeInOut(duration: 0.25)) {
                    filterHue = newValue.hueDegrees
                    filterSaturation = newValue.saturation
                }
            }

            VStack(spacing: 10) {
                HStack {
                    Text("色相偏移")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(Int(filterHue))°")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                Slider(value: $filterHue, in: -180...180, step: 1)
                    .tint(accentColor)

                HStack {
                    Text("色彩飽和度")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(filterSaturation, specifier: "%.2f")x")
                        .font(.caption.monospacedDigit())
                        .foregroundStyle(.secondary)
                }
                Slider(value: $filterSaturation, in: 0.3...2.0, step: 0.05)
                    .tint(accentColor)
            }
        }
        .horoyoiCardStyle()
    }

    private var tastingNotesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Button {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.78)) {
                    showNotes.toggle()
                }
            } label: {
                HStack {
                    Label("查看侍酒師風味筆記與下酒菜", systemImage: "text.book.closed.fill")
                        .font(.headline)
                    Spacer()
                    Image(systemName: showNotes ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.title3)
                }
                .foregroundStyle(.primary)
            }
            .buttonStyle(.plain)
            .horoyoiCardStyle()

            if showNotes {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("風味平衡雷達")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)

                        ratingMeterRow(title: "甜潤度", score: flavor.sweetness, symbol: "drop.fill")
                        ratingMeterRow(title: "酸爽度", score: flavor.acidity, symbol: "sparkles")
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("推薦下酒菜與微醺搭配")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)

                        LazyVGrid(
                            columns: [GridItem(.adaptive(minimum: 120), spacing: 8)],
                            alignment: .leading,
                            spacing: 8
                        ) {
                            ForEach(flavor.pairings, id: \.self) { pairing in
                                Label(pairing, systemImage: "fork.knife")
                                    .font(.caption.weight(.medium))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(accentColor.opacity(0.14), in: Capsule())
                            }
                        }
                    }

                    Text("建議飲用溫度：4°C - 6°C 冰鎮直飲或加入冰塊於玻璃杯中享用。")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .horoyoiCardStyle()
                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
            }
        }
    }

    private func ratingMeterRow(title: String, score: Int, symbol: String) -> some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(width: 52, alignment: .leading)

            HStack(spacing: 6) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= score ? symbol : "circle")
                        .font(.caption)
                        .foregroundStyle(index <= score ? accentColor : .secondary.opacity(0.4))
                }
            }

            Spacer()

            Text("\(score) / 5")
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
        }
    }
}
