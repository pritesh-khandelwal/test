//
//  userCollCell.swift
//  test
//
//  Created by Pritesh Khandelwal on 12/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

class userCollCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collImage: UIImageView!
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var claps: UILabel!
    
    static var identifier: String {
        return "userCollCell"
    }
    
    var item: Entity?{
        didSet{
            bindData()
        }
    }
    
    var sectiontype :Sectiontype?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collImage.layer.cornerRadius = collImage.frame.size.width/2
        collImage.clipsToBounds = true
        // Initialization code
        
    }
    
    func bindData(){
        if let data = item , let section = self.sectiontype{
            var imageUrl = ""
            switch section  {
            case .user:
                imageUrl = data.imageUrl ?? ""
                self.fname.text = data.firstName ?? ""
                self.lName.text = data.lastName ?? ""
                self.claps.text = String(data.totalProjectClaps ?? 0)
                self.collImage.imageFromServerURL(urlString: imageUrl)
                //self.collImage.sd_setImage(with: URL(string:imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            default:
                print("default")
            }
        }
        
    }
    
}
