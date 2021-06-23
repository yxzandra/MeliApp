// MARK: - Search
struct Search: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id, siteID, title: String
    let price: Double
    let currencyID: String
    let acceptsMercadopago: Bool
    let thumbnail: String
    let address: Address?
    let installments: Installments?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title, price
        case currencyID = "currency_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case thumbnail, address, installments
    }
}

// MARK: - Address
struct Address: Codable {
    let stateName, cityName: String

    enum CodingKeys: String, CodingKey {
        case stateName = "state_name"
        case cityName = "city_name"
    }
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyID: String

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}
