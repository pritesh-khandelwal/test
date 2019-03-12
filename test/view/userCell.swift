//
//  userCell.swift
//  test
//
//  Created by Pritesh Khandelwal on 12/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

class userCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var claps: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
    }
    
    var item: user?{
        didSet{
            bindData()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData(){
        if let data = item{
            self.fName.text = data.firstName ?? ""
            self.lName.text = data.lastName ?? ""
            self.claps.text = String(data.totalProjectClaps ?? 0)
            self.userImage.imageFromServerURL(urlString: data.imageUrl ?? "")
           // self.userImage.sd_setImage(with: URL(string:data.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
    }
    
}
