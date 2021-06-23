import UIKit

class ErrorSearchCell: UITableViewCell {
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    private typealias Constants = SearchViewConstants.ErrorSearchCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTitleLabel()
        prepareSubtitleLabel()
        prepareImage()
        prepareContentView()
    }

    private func prepareTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginTopBottom
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginError
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: imageError.trailingAnchor,
                constant: Constants.marginError
            )
        ])
    }

    private func prepareSubtitleLabel() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.topAnchor,
                constant: Constants.marginTopTitle
            ),
            
            subtitleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginError
            ),
            
            subtitleLabel.leadingAnchor.constraint(
                equalTo: imageError.trailingAnchor,
                constant: Constants.marginError
            )
        ])
    }

    private func prepareImage() {
        NSLayoutConstraint.activate([
            imageError.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginError
            ),
            
            imageError.heightAnchor.constraint(
                equalToConstant: Constants.sizeImageError
            ),
            
            imageError.widthAnchor.constraint(
                equalToConstant: Constants.sizeImageError
            )
        ])
        Layout.marginPin(of: imageError, in: contentView)
    }
    
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: imageError.bottomAnchor,
            constant: Constants.marginTopBottom
        ).isActive = true
    }
}
