//
//  imageCollCell.swift
//  test
//
//  Created by Pritesh Khandelwal on 11/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit


class imageCollCell: UICollectionViewCell {
    @IBOutlet weak var collImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var item: Entity?{
        didSet{
            bindData()
        }
    }
    var sectiontype :Sectiontype?
    static var identifier: String {
        return "imageCollCell"
    }
    
    func bindData(){
        if let data = item , let section = self.sectiontype{
            var imageUrl = ""
            switch section  {
            case .banner:
                imageUrl = data.imageUrl ?? ""
            case .dex:
                imageUrl = data.imageUrl ?? ""
            case .user:
                print("user")
            case .requirement:
                imageUrl = data.dex?.imageUrl ?? ""
            }
            self.collImage.imageFromServerURL(urlString: imageUrl)
            //self.collImage.sd_setImage(with: URL(string:imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
}
