import Foundation

struct MarvelConstants {
   
    static let publicKey = "b64b2574549f20514cddfe770e958632"
    static let privateKey = "d1f327fa1e86f17f72ed47fd0d88dc3c97276739"
    static let baseUrl = URL(string: "https://gateway.marvel.com:443/v1/public")!
    static let characterPath = "/characters"
    static var timestamp: String {
        return String(Date().timeIntervalSinceNow)
    }
    
    static var hash: String {
        return "\(timestamp)\(privateKey)\(publicKey)".MD5()
    }
}

struct HeroText {
   
    static let loading = "Loading"
    static let HeroTab = "Heroes"
    static let favTab = "Favorites"

 
}
