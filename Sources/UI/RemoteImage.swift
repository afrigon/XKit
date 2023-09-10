import SwiftUI
import NukeUI
import Nuke

public struct RemoteImage<Placeholder: View>: View {
    let image: URL?
    let resizingMode: ImageResizingMode
    let placeholder: () -> Placeholder

    public var body: some View {
        if let image {
            LazyImage(url: image) { state in
                if let image = state.image {
                    image.resizingMode(resizingMode)
                } else {
                    placeholder()
                }
            }
        } else {
            placeholder()
        }
    }

    public init(
        image: URL?,
        resizingMode: ImageResizingMode = .aspectFill,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.image = image
        self.resizingMode = resizingMode
        self.placeholder = placeholder
    }
}
