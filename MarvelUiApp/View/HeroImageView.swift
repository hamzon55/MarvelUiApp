import SwiftUI
import Kingfisher

struct HeroImageView: View {
    let imageURL: String
      
    var body: some View {
        KFImage(URL(string: imageURL))
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
}

  struct HeroImageView_Previews: PreviewProvider {
      static var previews: some View {
            HeroImageView(imageURL: "https://example.com/spiderman.jpg")
                 .previewLayout(.sizeThatFits)
         }
     }
