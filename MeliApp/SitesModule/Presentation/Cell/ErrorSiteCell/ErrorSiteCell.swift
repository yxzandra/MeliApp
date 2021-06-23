import UIKit

class ErrorSiteCell: UITableViewCell {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var retryLabel: UILabel!
    
    private typealias Constants = SitesViewConstants.ErrorSiteCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTitleLabel()
        prepareSubtitleLabel()
        prepareImage()
        prepareRetryLabel()
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
                equalTo: errorImage.trailingAnchor,
                constant: Constants.marginError
            ),
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
                equalTo: errorImage.trailingAnchor,
                constant: Constants.marginError
            )
        ])
    }

    private func prepareImage() {
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginError
            ),
            
            errorImage.heightAnchor.constraint(
                equalToConstant: Constants.sizeImageError
            ),
            
            errorImage.widthAnchor.constraint(
                equalToConstant: Constants.sizeImageError
            )
        ])

        Layout.marginPin(of: errorImage, in: contentView)
    }
    
    private func prepareRetryLabel() {
        retryLabel.topAnchor.constraint(
            equalTo: errorImage.bottomAnchor,
            constant: Constants.marginError
        ).isActive = true
        
        Layout.marginPin(of: retryLabel, in: contentView)
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: retryLabel.bottomAnchor,
            constant: Constants.marginTopBottom
        ).isActive = true
    }
}
