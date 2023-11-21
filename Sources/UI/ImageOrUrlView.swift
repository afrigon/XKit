import SwiftUI
import Nuke
import NukeUI

struct ImageOrUrlView<Content: View>: View {
    let image: ImageOrURL?
    let contentMode: ContentMode
    let content: () -> Content

    init(image: ImageOrURL? = nil, contentMode: ContentMode = .fill, content: @escaping () -> Content = { Color.clear }) {
        self.image = image
        self.contentMode = contentMode
        self.content = content
    }

    var resizingMode: ImageResizingMode {
        switch contentMode {
            case .fit:
                .aspectFit
            case .fill:
                .aspectFill
        }
    }

    var body: some View {
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
