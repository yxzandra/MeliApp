import UIKit

enum SitesViewConstants {
    static let titleView = "Paises Asociados"
    static let formatError = "%@ %d : \n %@"
    
    enum ErrorSiteCell {
        static let marginTopTitle = CGFloat(3)
        static let marginError = CGFloat(10)
        static let marginTopBottom = CGFloat(45)
        static let sizeImageError = CGFloat(90)
    }

    enum NibCell {
        static let nibTitleSiteCell = "TitleSiteCell"
        static let nibItemSiteCell = "ItemSiteCell"
        static let nibErrorSiteCell = "ErrorSiteCell"
    }
}
