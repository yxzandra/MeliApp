import UIKit

class DetailMapper {
    private var pictureMapper = PictureMapper()
    
    convenience init(pictureMapper: PictureMapper) {
        self.init()
        self.pictureMapper = pictureMapper
    }
    
    func reverseMap(value: Detail) -> DetailViewModel {
        let viewModel = DetailViewModel(
            id: value.id,
            title: value.title,
            idSite: value.siteID,
            price: calculatePrice(value.price, value.currencyID),
            availableQuantity: String(value.availableQuantity),
            soldQuantity: String(value.soldQuantity),
            pictures: pictureMapper.reverseMap(values: value.pictures),
            status: value.status == "active",
            warranty: value.warranty ?? "Sin garantía",
            description: nil
        )
        return viewModel
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
}
