import SwiftUI

struct FlavorListView: View {
    var body: some View {
        NavigationStack {
            List(HoroyoiData.flavors) { flavor in
                NavigationLink(destination: FlavorDetailView(flavor: flavor)) {
                    flavorRow(for: flavor)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            }
            .listStyle(.insetGrouped)
            .navigationTitle("全系列風味一覽")
        }
    }

    private func flavorRow(for flavor: FlavorItem) -> some View {
        let accent = Color(hex: flavor.accentColorHex)

        return HStack(spacing: 14) {
            HoroyoiAssetImage(
                assetName: flavor.imageName,
                accentColor: accent,
                fallbackSymbol: "wineglass.fill",
                compact: true
            )
            .frame(width: 60, height: 68)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .strokeBorder(accent.opacity(0.28), lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(flavor.name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    if flavor.isSeasonal {
                        Text("限定")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(accent)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(accent.opacity(0.16), in: Capsule())
                    }
                }

                Text(flavor.jpName)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 10) {
                    Text("\(flavor.abv, specifier: "%.0f")% ABV")
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(.ultraThinMaterial, in: Capsule())
                        .overlay(
                            Capsule()
                                .strokeBorder(accent.opacity(0.4), lineWidth: 0.8)
                        )

                    HStack(spacing: 2) {
                        Text("甜度")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= flavor.sweetness ? "star.fill" : "star")
                                .font(.caption2)
                                .foregroundStyle(star <= flavor.sweetness ? accent : .secondary.opacity(0.4))
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
