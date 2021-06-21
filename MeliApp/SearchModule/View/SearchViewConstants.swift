import UIKit

enum SearchViewConstants {
    // MARK: ViewController
    static let titleView = "Busca tu artículo"
    static let formatItemMercadoPago = "%dx %@ %@"
    static let formatAddress = "%@ %@"
    static let sinInteres = "sin interés"
    
    enum SearchCell {
        // MARK: SearchCell
        static let placeholderTextField = "Buscar en Mercado Libre"
        static let titleSearchButton = "Buscar"
        static let marginSearch = CGFloat(20)
        static let marginLeftTextField = CGFloat(12)
    }
    
    enum ItemSearchCell {
        static let marginItem = CGFloat(10)
        static let marginBetweenLabel = CGFloat(3)
        static let sizeImageItem = CGFloat(90)
    }
    
    enum ErrorSearchCell {
        static let marginTopTitle = CGFloat(3)
        static let marginError = CGFloat(10)
        static let marginTopBottom = CGFloat(45)
        static let sizeImageError = CGFloat(90)
    }
    
    enum NibCell {
        static let nibSearchCell = "SearchCell"
        static let nibItemSearchCell = "ItemSearchCell"
        static let nibErrorSearchCell = "ErrorSearchCell"
    }
}

