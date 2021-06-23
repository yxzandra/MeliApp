import UIKit

class ItemSiteCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareNameLabel()
    }

    private func prepareNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            nameLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
        Layout.marginPin(of: nameLabel, in: contentView, constant: CGFloat(6))
    }
}
