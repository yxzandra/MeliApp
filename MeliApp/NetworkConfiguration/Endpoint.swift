enum Endpoint {
    static let urlBase = "https://api.mercadolibre.com"
    
    static let site = urlBase + "/sites"
    static let search = urlBase + "/sites/{idSite}/search"
    static let detail = urlBase + "/items/{idItem}"
    static let detailDescription = urlBase + "/items/{idItem}/description"
}
