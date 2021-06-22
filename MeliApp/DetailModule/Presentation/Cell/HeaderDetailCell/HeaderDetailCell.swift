import UIKit

class HeaderDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var soldQuantityLabel: UILabel!
    @IBOutlet weak var avalilableQuantityLabel: UILabel!
    @IBOutlet weak var warantyLabel: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    
    private typealias Constants = DetailViewConstants.HeaderDetailCell

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTitleLabel()
        prepareFirstStackView()
        prepareSecondStackView()
        prepareContentView()
    }
    
    private func prepareTitleLabel() {
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.marginCell
        ).isActive = true

        Layout.marginPin(of: titleLabel, in: contentView)
    }
    
    private func prepareFirstStackView() {
        firstStackView.topAnchor.constraint(
            equalTo: titleLabel.topAnchor,
            constant: Constants.marginCell
        ).isActive = true
        
        Layout.marginPin(of: firstStackView, in: contentView)
    }
    
    private func prepareSecondStackView() {
        secondStackView.topAnchor.constraint(
            equalTo: firstStackView.topAnchor,
            constant: Constants.marginCell
        ).isActive = true
        
        Layout.marginPin(of: secondStackView, in: contentView)
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: secondStackView.bottomAnchor,
            constant: Constants.marginCell
        ).isActive = true
    }
}
