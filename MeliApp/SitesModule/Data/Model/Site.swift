struct Site: Decodable {
    let id: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

