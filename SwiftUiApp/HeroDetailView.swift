import SwiftUI

import SwiftUI

struct HeroDetailView: View {
    let hero: Character // The hero object passed to this view
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Display hero image
                AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension)")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 300, alignment: .center)
                            .cornerRadius(10)
                    } else if phase.error != nil {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .foregroundColor(.red)
                    } else {
                        ProgressView()
                            .frame(width: 400, height: 300)
                    }
                }
                .padding()
                
                // Hero name
                Text(hero.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Hero description
                Text(hero.description.isEmpty ? "No description available." : hero.description)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
            .navigationTitle(hero.name) // Set the title of the NavigationView to the hero's name
            .navigationBarTitleDisplayMode(.inline) // Display the title in a compact way
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
