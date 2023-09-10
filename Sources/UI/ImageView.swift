import SwiftUI
import NukeUI

public enum ImageView<Placeholder: View>: View {
    case url(URL, ImageResizingMode = .aspectFill, () -> Placeholder)
    case image(SwiftUI.Image)

    public var body: some View {
        switch self {
            case .url(let url, let resizingMode, let placeholder):
                RemoteImage(image: url, resizingMode: resizingMode, placeholder: placeholder)
            case .image(let image):
                image
        }
    }
}
