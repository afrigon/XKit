import SwiftUI
import Nuke
import NukeUI

public struct ImageOrURLView<Content: View>: View {
    let image: ImageOrURL?
    let contentMode: ContentMode
    let content: () -> Content

    public init(
        _ image: ImageOrURL? = nil,
        contentMode: ContentMode = .fill,
        content: @escaping () -> Content = { EmptyView() }
    ) {
        self.image = image
        self.contentMode = contentMode
        self.content = content
    }

    private var resizingMode: ImageResizingMode {
        switch contentMode {
            case .fit:
                .aspectFit
            case .fill:
                .aspectFill
        }
    }

    public var body: some View {
        if let image {
            switch image {
                case .image(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .url(let url):
                    LazyImage(url: url) { state in
                        if let image = state.image {
                            image.resizingMode(resizingMode)
                        } else {
                            content()
                        }
                    }
            }
        } else {
            content()
        }
    }
}
