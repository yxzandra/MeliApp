import UIKit

class ErrorSiteCell: UITableViewCell {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var retryLabel: UILabel!
    
    typealias Constants = SitesViewConstants.ErrorSiteCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTitleLabel()
        prepareSubtitleLabel()
        prepareImage()
        prepareRetryLabel()
        prepareContentView()
    }
    
    private func prepareTitleLabel() {
        titleLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.marginTopBottom
        ).isActive = true
        
        titleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginError
        ).isActive = true
        
        titleLabel.leadingAnchor.constraint(
            equalTo: errorImage.trailingAnchor,
            constant: Constants.marginError
        ).isActive = true
    }

    private func prepareSubtitleLabel() {
        subtitleLabel.topAnchor.constraint(
            equalTo: titleLabel.topAnchor,
            constant: Constants.marginTopTitle
        ).isActive = true
        
        subtitleLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.marginError
        ).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(
            equalTo: errorImage.trailingAnchor,
            constant: Constants.marginError
        ).isActive = true
    }

    private func prepareImage() {
        errorImage.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.marginError
        ).isActive = true
        
        errorImage.heightAnchor.constraint(
            equalToConstant: Constants.sizeImageError
        ).isActive = true
        
        errorImage.widthAnchor.constraint(
            equalToConstant: Constants.sizeImageError
        ).isActive = true
        
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
