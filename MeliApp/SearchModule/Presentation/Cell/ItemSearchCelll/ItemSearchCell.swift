import UIKit

class ItemSearchCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mercadoPriceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    private typealias Constants = SearchViewConstants.ItemSearchCell
    
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
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginItem
            ),
            itemImage.heightAnchor.constraint(
                equalToConstant: Constants.sizeImageItem
            ),
            itemImage.widthAnchor.constraint(
                equalToConstant: Constants.sizeImageItem
            ),
            itemImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.marginItem
            )
        ])
        
        itemImage.contentMode = .scaleToFill
    }

    private func prepareTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: CGFloat(5)
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginItem
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: itemImage.trailingAnchor,
                constant: -Constants.marginItem
            )
        ])
    }

    private func preparePriceLabel() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: Constants.marginBetweenLabel
            ),
            priceLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginItem
            ),
            priceLabel.leadingAnchor.constraint(
                equalTo: itemImage.trailingAnchor,
                constant: Constants.marginItem
            )
        ])
    }

    private func prepareMercadoPriceLabel() {
        NSLayoutConstraint.activate([
            mercadoPriceLabel.topAnchor.constraint(
                equalTo: priceLabel.topAnchor,
                constant: Constants.marginBetweenLabel
            ),
            mercadoPriceLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginItem
            ),
            mercadoPriceLabel.leadingAnchor.constraint(
                equalTo: itemImage.trailingAnchor,
                constant: Constants.marginItem
            )
        ])
    }

    private func prepareAddressLabel() {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(
                equalTo: mercadoPriceLabel.topAnchor,
                constant: Constants.marginBetweenLabel
            ),
            addressLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginItem
            ),
            addressLabel.leadingAnchor.constraint(
                equalTo: itemImage.trailingAnchor,
                constant: Constants.marginItem
            )
        ])
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: itemImage.bottomAnchor,
            constant: Constants.marginItem
        ).isActive = true
    }
}
