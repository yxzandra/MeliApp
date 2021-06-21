import UIKit

class ItemSiteCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareNameLabel()
    }

    private func prepareNameLabel() {
        nameLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor
        ).isActive = true

        nameLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        ).isActive = true
        
        Layout.marginPin(of: nameLabel, in: contentView, constant: CGFloat(6))
    }
}
