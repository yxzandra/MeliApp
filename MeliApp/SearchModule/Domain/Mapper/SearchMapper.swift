import UIKit

class SearchMapper {
    private typealias Constants = SearchViewConstants
    
    func reverseMap(value: Result) -> SearchViewModel {
        let viewModel = SearchViewModel(
            id: value.id,
            title: value.title,
            idSite: value.siteID,
            price: calculatePrice(Double(value.price), value.currencyID),
            mercadoPago: calculateMercadoPago(isValidate: value.acceptsMercadopago, installments: value.installments),
            thumbnail: value.thumbnail,
            address: calculateAddress(address: value.address)
        )
        return viewModel
    }
    
    func reverseMap(values: [Result]) -> [SearchViewModel] {
        var newValues = [SearchViewModel]()
        values.forEach { value in
            newValues.append(reverseMap(value: value))
        }
        return newValues
    }
    
    private func calculatePrice(_ amount: Double, _ currencyID: String) -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = getSymbol(forCurrencyCode: currencyID)
        formatter.numberStyle = .currency
        return formatter.string(for: amount) ?? ""
    }
    
    private func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
    
    private func calculateAddress(address: Address?) -> String {
        if let address = address {
            return String(format: Constants.formatAddress, address.stateName, address.cityName)
        } else {
            return ""
        }
    }
    
    private func calculateMercadoPago(isValidate: Bool, installments: Installments?) -> String {
        if let item = installments, isValidate {
            let amount = calculatePrice(item.amount, item.currencyID)
            let rate = item.rate == .zero ? Constants.sinInteres : String(item.rate)
            return String(format: Constants.formatItemMercadoPago, item.quantity, amount, rate)
        } else {
            return ""
        }
    }
}
