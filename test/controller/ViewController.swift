//
//  ViewController.swift
//  test
//
//  Created by Pritesh Khandelwal on 11/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import UIKit

//protocol for sending click event from cell
protocol imageCellDelegate: class{
     func didTapUserRow(id : String)
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let imageCellIdentifier = "imageCell"
    var dataSouceArr : RootClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.apiCall()
    }
    func setup(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "imageCell", bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if let dataArr = self.dataSouceArr{
            return dataArr.explore.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier) as! imageCell
        if let dataArr = self.dataSouceArr{
            cell.item = dataArr.explore[indexPath.section]
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let dataArr = self.dataSouceArr{
            return dataArr.explore[section].title
        }else{
            return ""
        }
    }
}

extension ViewController:imageCellDelegate{
    func didTapUserRow(id: String) {
        let vc = userList(nibName:"userList", bundle:nil)
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController{
    //function call for get data from api
    func apiCall(){
        guard let gitUrl = URL(string: "https://valakt.dextra.com/explore") else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.dataSouceArr = try decoder.decode(RootClass.self, from: data)
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        }
}

