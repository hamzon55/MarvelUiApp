import SwiftUI

struct HeroCell: View {
    let hero: Character

    var body: some View {
        
        HStack(alignment: .center) {
            HeroImageView(imageURL: "\(hero.thumbnail.fullPath)")
            
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.headline)
                Text(hero.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            .padding(.leading, 5)
        }
        .padding(.vertical, 5)
    }
          }

struct HeroCell_Previews: PreviewProvider {
    static var previews: some View {
        HeroCell(hero: Character(
            id: 1,
            name: "Spider-Man",
            description: "A hero with spider-like abilities.", thumbnail: Thumbnail(path: "", thumbnailExtension: ".")
        ))
        .previewLayout(.sizeThatFits)
    }
}
