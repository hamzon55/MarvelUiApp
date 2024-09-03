import Foundation
/// Represents a single Marvel Series.
public struct Character: Codable, Equatable {
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    init(id: Int, name: String, description: String,  thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
    
    var descriptionText: String {
        return description.isEmpty == false ? description : "Description not available."
    }
}

struct Thumbnail: Codable, Equatable {
    
    let path: String
    let thumbnailExtension: String
    
    var fullPath: String {
        return "\(path).\(thumbnailExtension)"
    }
    
    var url: URL? { URL(string: "\(path).\(thumbnailExtension)") }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
