import SwiftUI

struct HeroCell: View {
    let hero: Character

    var body: some View {
        VStack(alignment: .leading) {
                      Text(hero.name)
                          .font(.headline)
                      Text(hero.description)
                          .font(.subheadline)
                          .foregroundColor(.gray)
                          .lineLimit(2) // Limit description to 2 lines
                  }
                  .padding(.leading, 8)
              }
          }

struct HeroCell_Previews: PreviewProvider {
    static var previews: some View {
        HeroCell(hero: Character(
            id: 1,
            name: "Spider-Man",
            description: "A hero with spider-like abilities."
        ))
        .previewLayout(.sizeThatFits)
    }
}
