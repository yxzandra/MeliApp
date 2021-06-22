// MARK: - Detail
struct Detail: Codable {
    let id, siteID, title: String
    let price: Double
    let currencyID: String
    let availableQuantity, soldQuantity: Int
    let pictures: [Picture]
    let status, warranty: String

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, price
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case pictures, status, warranty
    }
}

// MARK: - Picture
struct Picture: Codable {
    let url: String
}
