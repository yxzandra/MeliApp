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
        
        Layout.marginPin(of: contentLabel, in: contentView)
    }
    
    private func prepareContentLabel() {
        contentLabel.topAnchor.constraint(
            equalTo: logoImage.topAnchor
        ).isActive = true
        
        contentLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        ).isActive = true
        
        Layout.marginPin(of: contentLabel, in: contentView)
    }
}
