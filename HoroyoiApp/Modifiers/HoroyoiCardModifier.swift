import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Frosted editorial card styling adapting cleanly between Light Mode and Dark Mode.
struct HoroyoiCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.primary.opacity(0.08), lineWidth: 1)
            )
            .shadow(color: .primary.opacity(0.06), radius: 14, x: 0, y: 6)
    }
}

extension View {
    /// Applies Horoyoi's frosted material card container with rounded corners, hairline border, and soft shadow.
    func horoyoiCardStyle(cornerRadius: CGFloat = 20, padding: CGFloat = 16) -> some View {
        modifier(HoroyoiCardModifier(cornerRadius: cornerRadius, padding: padding))
    }
}

extension Color {
    /// Creates an sRGB Color from a 6-digit hex string (with or without leading `#`).
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}

/// Renders an asset from `Assets.xcassets` when present, or a vibrant placeholder slot until the artwork is added.
struct HoroyoiAssetImage: View {
    enum ContentMode {
        case fit
        case fill
    }

    let assetName: String
    let accentColor: Color
    let fallbackSymbol: String
    var contentMode: ContentMode = .fit
    var compact: Bool = false

    private var hasBundleAsset: Bool {
        #if canImport(UIKit)
        UIImage(named: assetName) != nil
        #else
        false
        #endif
    }

    var body: some View {
        if hasBundleAsset {
            Group {
                switch contentMode {
                case .fit:
                    Image(assetName)
                        .resizable()
                        .scaledToFit()
                case .fill:
                    Image(assetName)
                        .resizable()
                        .scaledToFill()
                }
            }
        } else {
            placeholderView
        }
    }

    private var placeholderView: some View {
        ZStack {
            LinearGradient(
                colors: [
                    accentColor.opacity(0.32),
                    accentColor.opacity(0.14),
                    Color.purple.opacity(0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(accentColor.opacity(0.22))
                .scaleEffect(0.72)
                .blur(radius: compact ? 6 : 18)

            VStack(spacing: compact ? 2 : 8) {
                Image(systemName: fallbackSymbol)
                    .font(compact ? .title3 : .system(size: 42, weight: .light))
                    .foregroundStyle(accentColor)

                if !compact {
                    Text("圖片預留位置")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Text(assetName)
                        .font(.caption.monospaced())
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .foregroundStyle(.primary.opacity(0.85))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(.ultraThinMaterial, in: Capsule())
                }
            }
            .padding(compact ? 4 : 12)
        }
    }
}

/// Shared modal sheet displaying a selected lifestyle scene story card.
struct SceneStorySheet: View {
    let scene: ScenePhoto
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HoroyoiAssetImage(
                    assetName: scene.imageName,
                    accentColor: Color(hex: "#F48FB1"),
                    fallbackSymbol: "sparkles.rectangle.stack.fill",
                    contentMode: .fill
                )
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                VStack(alignment: .leading, spacing: 10) {
                    Text(scene.moodTag)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(Color(hex: "#E87A90"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hex: "#E87A90").opacity(0.14), in: Capsule())

                    Text(scene.title)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.primary)

                    Text("「\(scene.storyQuote)」")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .lineSpacing(5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .horoyoiCardStyle()

                Spacer()
            }
            .padding()
            .navigationTitle("微醺生活故事")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
