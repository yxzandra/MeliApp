//
//  TitleSiteCell.swift
//  MeliApp
//
//  Created by Yxzandra Cordero on 14-06-21.
//

import UIKit

class TitleSiteCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareLogoImage()
        prepareContentLabel()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareLogoImage() {
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
    
    func prepareContentLabel() {
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
