//
//  SecondViewController.swift
//  TRENGDict
//
//  Created by berk birkan on 2.08.2019.
//  Copyright © 2019 berk birkan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "fav", for: indexPath)
        
        cell.textLabel?.text = DBManager.sharedInstance.getDataFromDB()[indexPath.row].word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: DBManager.sharedInstance.getDataFromDB()[indexPath.row].word , message: DBManager.sharedInstance.getDataFromDB()[indexPath.row].mean, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
       
    }


}

