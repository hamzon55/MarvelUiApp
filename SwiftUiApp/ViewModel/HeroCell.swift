import SwiftUI

struct HeroCell: View {
    let hero: Character

    var body: some View {
        
        HStack(alignment: .center) {
            // Use the refactored HeroImageView component
            HeroImageView(imageURL: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension)")
            
            VStack(alignment: .leading) {
                Text(hero.name)
                    .font(.headline)
                Text(hero.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2) 
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
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
