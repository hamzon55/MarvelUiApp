import SwiftUI
import Kingfisher

struct HeroDetailView: View {
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
            .navigationTitle(hero.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Preview
struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(hero: Character(
            id: 1,
            name: "Spider-Man",
            description: "A hero with spider-like abilities.",
            thumbnail: Thumbnail(path: "https://example.com/spiderman", thumbnailExtension: "jpg")
        ))
    }
}
