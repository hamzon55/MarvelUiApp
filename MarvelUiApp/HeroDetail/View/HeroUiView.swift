import SwiftUI
import Kingfisher

struct HeroUiView: View {
    let hero: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                KFImage(URL(string: "\(hero.thumbnail.fullPath)"))
                    .placeholder {
                        ProgressView()
                            .frame(width: 400, height: 300)
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300, alignment: .center)
                    .cornerRadius(10)
                    .padding()
                
                Text(hero.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                
                Text(hero.description.isEmpty ? "No description available." : hero.description)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
        }
    }
}
