import SwiftUI

public struct ImageView<Content: View, P: View>: View {
    let image: ImageSource?
    let content: (Image) -> Content
    let placeholder: () -> P

    public init(
        _ image: ImageSource? = nil,
        content: @escaping (Image) -> Content = { $0 },
        placeholder: @escaping () -> P = { EmptyView() }
    ) {
        self.image = image
        self.content = content
        self.placeholder = placeholder
    }

    public var body: some View {
        if let image {
            switch image {
                case .local(let image):
                    content(image)
                case .remote(let url):
                    AsyncImage(
                        url: url,
                        content: { image in
                            content(image)
                        },
                        placeholder: {
                            placeholder()
                        }
                    )
            }
        } else {
            placeholder()
        }
    }
}
