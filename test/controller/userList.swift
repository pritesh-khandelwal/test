//
//  userList.swift
//  test
//
//  Created by Pritesh Khandelwal on 12/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

class userList: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "userCell"
    var id = ""
    var lastIndex = 0
    var dataSouceArr = userResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "userCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.apiCall(indexpath: 0)
    }
    
}

extension userList:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataSouceArr.users.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == self.dataSouceArr.users.count){
            self.apiCall(indexpath: indexPath.row)
            return UITableViewCell()
        }else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! userCell
            cell.item = self.dataSouceArr.users[indexPath.row]
            return cell
        }
        
    }
}

extension userList{
    func apiCall(indexpath:Int){
        if(indexpath != 0 && indexpath < lastIndex){
            return
        }else{
            lastIndex = indexpath
        }
        guard let gitUrl = URL(string: "https://valakt.dextra.com/explore/user?dexId=\(self.id)") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let getData = try decoder.decode(userResponse.self, from: data)
                self.dataSouceArr.next = getData.next
                self.dataSouceArr.users.append(contentsOf: getData.users)
                if (self.dataSouceArr.next != ""){
                    let nextString = (self.dataSouceArr.next.components(separatedBy: "&"))[0]
                    let id = (nextString.components(separatedBy: "="))[1]
                    self.id = id
                }
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
