import SwiftUI

struct CircularProgressView: View {
    var body: some View {
        Circle()
            .stroke( // 1
                Color.pink.opacity(0.5),
                lineWidth: 30
            )
    }
}

