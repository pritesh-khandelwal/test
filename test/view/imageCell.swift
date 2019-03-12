//
//  imageCell.swift
//  test
//
//  Created by Pritesh Khandelwal on 11/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit



enum Sectiontype {
    case dex
    case user
    case requirement
    case banner
}

class imageCell: UITableViewCell {
    @IBOutlet weak var collview: UICollectionView!
    var item: Explore?{
        didSet{
            bindData()
        }
    }
    var sectiontype :Sectiontype?
    weak var delegate: imageCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    func setup(){
        self.collview.dataSource = self
        self.collview.delegate = self
        self.collview.register(UINib(nibName: imageCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: imageCollCell.identifier)
        self.collview.register(UINib(nibName: userCollCell.identifier, bundle: nil), forCellWithReuseIdentifier: userCollCell.identifier)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(){
        if let cellItem = item{
            if(cellItem.sectionType == "dex"){
                self.sectiontype = Sectiontype.dex
            }else if(cellItem.sectionType == "user"){
                self.sectiontype = Sectiontype.user
            }else if(cellItem.sectionType == "requirement"){
                self.sectiontype = Sectiontype.requirement
            }else if(cellItem.sectionType == "banner"){
                self.sectiontype = Sectiontype.banner
            }
        }
        self.collview.reloadData()
    }
}

extension imageCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.item != nil{
            return 1
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let explore = self.item{
            return explore.entities.count
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let explore = self.item,let section = self.sectiontype{
            switch section  {
            case .banner,.dex,.requirement:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollCell.identifier, for: indexPath) as! imageCollCell
                cell.sectiontype = section
                cell.item = explore.entities[indexPath.row]
                return cell
            case .user:
                let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: userCollCell.identifier, for: indexPath) as! userCollCell
                cell.sectiontype = section
                cell.item = explore.entities[indexPath.row]
                return cell
            }
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        var  width:CGFloat = 100.0
        if let section = self.sectiontype ,let explore = self.item{
            switch section {
            case .banner:
                width = self.frame.width - 2
            case .dex:
                width = CGFloat(150 * (explore.entities[indexPath.row].imageRatio ?? 1.0))
            case .user:
                width = self.frame.width * 0.5
            case .requirement:
                width = CGFloat(150 * (explore.entities[indexPath.row].dex?.imageRatio ?? 1.0))
            }
            
        }
        let size = CGSize(width: width, height: 150)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let section = self.sectiontype ,let explore = self.item{
            switch section {
            case .banner:
                let strUrl = explore.entities[indexPath.row].actionUrl ?? ""
                let newLink = strUrl.replacingOccurrences(of: "http://", with: "googlechrome://")
                if let url = URL(string: newLink){
                    if (UIApplication.shared.canOpenURL(url)) {
                        UIApplication.shared.open(URL(string: newLink)!, options: [:], completionHandler: nil)
                    }
                    else{
                        UIApplication.shared.open(URL(string: strUrl)!, options: [:], completionHandler: nil)
                    }
                }else{
                    UIApplication.shared.open(URL(string: strUrl)!, options: [:], completionHandler: nil)
                }
            case .dex:
                delegate?.didTapUserRow(id: explore.entities[indexPath.row].id ?? "")
            case .user,.requirement:
                print("test")
            }
            
        }
    }
}
