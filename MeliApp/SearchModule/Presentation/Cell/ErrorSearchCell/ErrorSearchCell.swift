import UIKit

class ErrorSearchCell: UITableViewCell {
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    typealias Constants = SearchViewConstants.ErrorSearchCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareTitleLabel()
        prepareSubtitleLabel()
        prepareImage()
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
            equalTo: imageError.trailingAnchor,
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
            equalTo: imageError.trailingAnchor,
            constant: Constants.marginError
        ).isActive = true
    }

    private func prepareImage() {
        imageError.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.marginError
        ).isActive = true
        
        imageError.heightAnchor.constraint(
            equalToConstant: Constants.sizeImageError
        ).isActive = true
        
        imageError.widthAnchor.constraint(
            equalToConstant: Constants.sizeImageError
        ).isActive = true
        
        Layout.marginPin(of: imageError, in: contentView)
    }
    
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: imageError.bottomAnchor,
            constant: Constants.marginTopBottom
        ).isActive = true
    }
}
