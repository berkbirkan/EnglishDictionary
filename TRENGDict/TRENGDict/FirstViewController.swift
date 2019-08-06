//
//  FirstViewController.swift
//  TRENGDict
//
//  Created by berk birkan on 2.08.2019.
//  Copyright © 2019 berk birkan. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var words = [Word]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dict", for: indexPath)
        
        cell.textLabel!.text = words[indexPath.row].word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: words[indexPath.row].word, message: words[indexPath.row].mean, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        
        let addfav = UIAlertAction(title: "Add to Favorite", style: UIAlertAction.Style.default) { (deneme) in
            let sozcuk = Word()
            sozcuk.word = self.words[indexPath.row].word
            sozcuk.mean = self.words[indexPath.row].mean
            DBManager.sharedInstance.addData(object: sozcuk)
            
        }
        
        alert.addAction(ok)
        alert.addAction(addfav)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJSON()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    
    func getJSON(){
        
        if let path = Bundle.main.path(forResource: "english_german", ofType: "json") {
            do {
                let dataResponse = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                print(jsonResponse)
                
                let words = jsonResponse as! [String:Any]
                
                for word in words.keys{
                    let sozcuk = Word()
                    sozcuk.word = word
                    sozcuk.mean = words[word] as! String
                    self.words.append(sozcuk)
                }
            } catch {
                // handle error
            }
        }
        
    }


}

