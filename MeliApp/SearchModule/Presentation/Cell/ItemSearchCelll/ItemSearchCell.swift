import UIKit

class ItemSearchCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mercadoPriceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    typealias Constants = SearchViewConstants.ItemSearchCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareItemImage()
        prepareTitleLabel()
        preparePriceLabel()
        prepareMercadoPriceLabel()
        prepareAddressLabel()
        prepareContentView()
    }
    
    private func prepareItemImage() {
        itemImage.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.marginItem
        ).isActive = true
        
        itemImage.heightAnchor.constraint(
            equalToConstant: Constants.sizeImageItem
        ).isActive = true
        
        itemImage.widthAnchor.constraint(
            equalToConstant: Constants.sizeImageItem
        ).isActive = true
        
        itemImage.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.marginItem
        ).isActive = true
        
        itemImage.contentMode = .scaleToFill
    }

    private func prepareTitleLabel() {
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: CGFloat(5)
        ).isActive = true
        
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginItem
        ).isActive = true
        
        titleLabel.leadingAnchor.constraint(
            equalTo: itemImage.trailingAnchor,
            constant: -Constants.marginItem
        ).isActive = true
    }

    private func preparePriceLabel() {
        priceLabel.topAnchor.constraint(
            equalTo: titleLabel.topAnchor,
            constant: Constants.marginBetweenLabel
        ).isActive = true
        
        priceLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginItem
        ).isActive = true
        
        priceLabel.leadingAnchor.constraint(
            equalTo: itemImage.trailingAnchor,
            constant: Constants.marginItem
        ).isActive = true
    }

    private func prepareMercadoPriceLabel() {
        mercadoPriceLabel.topAnchor.constraint(
            equalTo: priceLabel.topAnchor,
            constant: Constants.marginBetweenLabel
        ).isActive = true

        mercadoPriceLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginItem
        ).isActive = true

        mercadoPriceLabel.leadingAnchor.constraint(
            equalTo: itemImage.trailingAnchor,
            constant: Constants.marginItem
        ).isActive = true
    }

    private func prepareAddressLabel() {
        addressLabel.topAnchor.constraint(
            equalTo: mercadoPriceLabel.topAnchor,
            constant: Constants.marginBetweenLabel
        ).isActive = true
        
        addressLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginItem
        ).isActive = true

        addressLabel.leadingAnchor.constraint(
            equalTo: itemImage.trailingAnchor,
            constant: Constants.marginItem
        ).isActive = true
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: itemImage.bottomAnchor,
            constant: Constants.marginItem
        ).isActive = true
    }
}
