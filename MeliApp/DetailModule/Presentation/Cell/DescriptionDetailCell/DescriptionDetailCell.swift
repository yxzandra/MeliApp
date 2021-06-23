import UIKit

class DescriptionDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var loadActivityIndicator: UIActivityIndicatorView!
    
    private typealias Constants = DetailViewConstants.DescriptionDetailCell
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            loadActivity()
            changeImageChevron(isSelected: selected)
        } else {
            stopAndHideActivity()
        }
    }
    
    func setDescription(description: String, isShow: Bool) {
        validateDescription(description: description, isShow: isShow)
        prepareTitleLabel()
        prepareChevronImage()
        prepareDescriptionTextView()
        prepareContentView()
        prepareLoadActivity()
        
    }
    
    private func changeImageChevron(isSelected: Bool) {
        if isSelected {
            chevronImage.image = .chevronDown
        } else {
            chevronImage.image = .chevronUp
        }
    }
    
    private func validateDescription(description: String, isShow: Bool) {
        changeImageChevron(isSelected: isShow)
        descriptionTextView.isHidden = description.isEmpty || !isShow
        descriptionTextView.text = description
    }
    
    private func prepareTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginCell
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.marginCell
            )
        ])
    }
    
    private func prepareChevronImage() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginCell
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginCell
            )
        ])
    }
    
    private func prepareDescriptionTextView() {
        contentView.layoutIfNeeded()
        let contentSize = descriptionTextView.contentSize.height
        descriptionTextView.contentInset = Constants.marginContentDescription
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.marginCell
            ),
            descriptionTextView.heightAnchor.constraint(
                equalToConstant: contentSize
            )
        ])
        
        Layout.marginPin(of: descriptionTextView, in: contentView)
        
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: descriptionTextView.bottomAnchor,
            constant: Constants.marginCell
        ).isActive = true
    }
    
    private func prepareLoadActivity() {
        loadActivityIndicator.topAnchor.constraint(
            equalTo: titleLabel.bottomAnchor,
            constant: Constants.marginLoadActivity
        ).isActive = true
        
        Layout.marginPin(of: loadActivityIndicator, in: contentView)
    }
    
    private func loadActivity() {
        self.loadActivityIndicator.startAnimating()
    }
    
    private func stopAndHideActivity() {
        self.loadActivityIndicator.stopAnimating()
        self.loadActivityIndicator.hidesWhenStopped = true
    }
}
