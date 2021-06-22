import UIKit

enum DetailViewConstants {
    static let titleView = "Detalle"
    static let soldFormat = "Vendidos: %@"
    static let availableFormat = "Disponibles: %@"
    
    enum HeaderDetailCell {
        static let marginCell = CGFloat(15)
    }
    
    enum DescriptionDetailCell {
        static let messageError = "Ocurrió un error en la consulta"
        static let marginCell = CGFloat(12)
        static let marginLoadActivity = CGFloat(20)
        static let marginContentDescription = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
    }
    
    enum NibCell {
        static let nibCarouselDetailCell = "CarouselDetailCell"
        static let nibHeaderDetailCell = "HeaderDetailCell"
        static let nibDescriptionDetailCell = "DescriptionDetailCell"
    }
}
