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
    
    var labelTitle : UILabel!
    var labelDescription : UILabel!
    var imageViewItem : UIImageView!
    var itemDetails : ItemDetails?

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.addItemsToView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelTitle.text = nil
        self.labelDescription.text = nil
        self.imageViewItem.image = nil
    }
    
//MARK:- Add controls in the view
    func addItemsToView()  {
        initControlls()
        setConstrainsts()
        setValues()
    }
    
//    MARK:- Initialzing controlles
    func initControlls()  {
        
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
        imageViewItem.layer.masksToBounds = true
        imageViewItem.contentMode = .scaleAspectFit
    }
    
//    MARK:- Set Constraints
    func setConstrainsts()  {
        let views = ["labelTitle" : labelTitle, "labelDescription" : labelDescription, "imageViewItem" : imageViewItem]
        var viewConstraints = [NSLayoutConstraint]()
        let imageViewItemHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imageViewItem(\(screenWidth/2.5))]", options: [], metrics: nil, views: views as [String : Any])
        viewConstraints += imageViewItemHorizontalContraints
        let labelTitleHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageViewItem]-10-[labelTitle]-10-|", options: [], metrics: nil, views: views as [String : Any])
        viewConstraints += labelTitleHorizontalContraints
        let labelDescriptionHorizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageViewItem]-10-[labelDescription]-10-|", options: [], metrics: nil, views: views as [String : Any])
        viewConstraints += labelDescriptionHorizontalContraints
        
        let labelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[labelTitle]-10-[labelDescription]-10-|", options: [], metrics: nil, views: views as [String : Any])
        viewConstraints += labelVerticalConstraints
        let imageViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imageViewItem]-10-|", options: [], metrics: nil, views: views as [String : Any])
        viewConstraints += imageViewVerticalConstraints
        
        NSLayoutConstraint.activate(viewConstraints)
    }
    
//    MARK:- Set Values
    func setValues()  {
        if let details = itemDetails {
            labelTitle.text = details.itemTitle ?? ""
            labelDescription.text = details.itemDescription ?? ""
            if let imageUrl = details.itemImage {
                self.imageViewItem?.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeHolderImage"),options: SDWebImageOptions(rawValue: 1) , completed: { (image, error, cacheType, imageURL) in
                    if image == nil {
                        self.imageViewItem.image = UIImage(named: "placeHolderImage")
                    }
                    
                })
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
