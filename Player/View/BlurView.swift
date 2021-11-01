
import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    }
}
