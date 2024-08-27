import Foundation

struct Movie: Identifiable, Codable {
    
    let id: Int
    let name: String
    let description: String
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

struct MovieResponse: Codable {
    
    let results: [Movie]
    
}
