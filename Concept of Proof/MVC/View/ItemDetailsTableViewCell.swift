//
//  ItemDetailsTableViewCell.swift
//  Concept of Proof
//
//  Created by Godwin on 30/06/20.
//  Copyright © 2020 Godwin. All rights reserved.
//

import UIKit
import SDWebImage

class ItemDetailsTableViewCell: UITableViewCell {
    
    class var identifier: String { return String.className(self) }
    
    var labelTitle: UILabel!
    var labelDescription: UILabel!
    var imageViewItem: UIImageView!
    var itemDetails: ItemDetails?

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reUseControls()
    }
    
    func reUseControls() {
        self.labelTitle.text = nil
        self.labelDescription.text = nil
        self.imageViewItem.image = nil
    }
    
// MARK: Initialzing controlles
    func initControlls() {
        
        labelTitle = UILabel()
        labelDescription = UILabel()
        imageViewItem = UIImageView()
        
        labelDescription.numberOfLines = 0
        labelTitle.numberOfLines = 0
        labelTitle.textColor = .black
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        labelDescription.textColor = .gray
        labelDescription.font = UIFont.systemFont(ofSize: 16.0)
        labelTitle.textAlignment = .left
        labelDescription.textAlignment = .left
        
        self.contentView.addSubview(labelTitle)
        self.contentView.addSubview(labelDescription)
        self.contentView.addSubview(imageViewItem)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        imageViewItem.translatesAutoresizingMaskIntoConstraints = false
        imageViewItem.clipsToBounds = true
        imageViewItem.contentMode = .scaleAspectFill
        let views = ["labelTitle": labelTitle, "labelDescription": labelDescription, "imageViewItem": imageViewItem]
        setConstrainsts(views: views as [String: Any])
        setValues(itemDetails: itemDetails, titleLabel: labelTitle, descLabel: labelDescription, imageView: imageViewItem)
        
    }
    
// MARK: Set Constraints
    func setConstrainsts(views: [String: Any]) {
        var viewConstraints = [NSLayoutConstraint]()
        let imageViewVisual = "H:|-10-[imageViewItem(\(screenWidth/2.5))]"
        let imageViewHC = NSLayoutConstraint.constraints(withVisualFormat: imageViewVisual, options: [], metrics: nil, views: views as [String: Any])
        viewConstraints += imageViewHC
        let labelTitleVisual = "H:[imageViewItem]-10-[labelTitle]-10-|"
        let labelTitlHC = NSLayoutConstraint.constraints(withVisualFormat: labelTitleVisual, options: [], metrics: nil, views: views as [String: Any])
        viewConstraints += labelTitlHC
        let decVisual = "H:[imageViewItem]-10-[labelDescription]-10-|"
        let labelDescHC = NSLayoutConstraint.constraints(withVisualFormat: decVisual, options: [], metrics: nil, views: views as [String: Any])
        viewConstraints += labelDescHC
        let verticalVisual = "V:|-10-[labelTitle(18)]-10-[labelDescription]-10-|"
        let labelVC = NSLayoutConstraint.constraints(withVisualFormat: verticalVisual, options: [], metrics: nil, views: views as [String: Any])
        viewConstraints += labelVC
        let imgVerticlVisual = "V:|-10-[imageViewItem]-10-|"
        let imageViewVC = NSLayoutConstraint.constraints(withVisualFormat: imgVerticlVisual, options: [], metrics: nil, views: views as [String: Any])
        viewConstraints += imageViewVC
        NSLayoutConstraint.activate(viewConstraints)
    }
    
// MARK: Set Values
    func setValues(itemDetails: ItemDetails?, titleLabel: UILabel, descLabel: UILabel, imageView: UIImageView) {
        if let details = itemDetails {
            titleLabel.text = details.itemTitle ?? ""
            descLabel.text = details.itemDescription ?? ""
            if let imageUrl = details.itemImage {
                let url = URL(string: imageUrl)
                let placeHolder = UIImage(named: "placeHolderImage")
                imageView.sd_setImage(with: url, placeholderImage: placeHolder, options: SDWebImageOptions(rawValue: 1), completed: nil)
            }
        }
    }

}
