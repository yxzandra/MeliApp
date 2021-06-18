struct Error: Decodable {
    let error: String
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case error
        case message
    }
}
