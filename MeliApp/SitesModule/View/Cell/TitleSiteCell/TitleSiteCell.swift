import UIKit

class TitleSiteCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareLogoImage()
        prepareContentLabel()
        
    }

    private func prepareLogoImage() {
        logoImage.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: CGFloat(12)
        ).isActive = true
        
        logoImage.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor
        ).isActive = true
        
        logoImage.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor
        ).isActive = true
        
    }
    
    private func prepareContentLabel() {
        contentLabel.topAnchor.constraint(
            equalTo: logoImage.topAnchor
        ).isActive = true
        
        contentLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor
        ).isActive = true
        
        contentLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor
        ).isActive = true
        
        contentLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        ).isActive = true
    }
}
