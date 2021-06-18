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
        
        nameLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: CGFloat(6)
        ).isActive = true
        
        nameLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: CGFloat(6)
        ).isActive = true

        nameLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        ).isActive = true
    }
}
