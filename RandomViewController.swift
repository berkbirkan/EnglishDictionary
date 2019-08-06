//
//  RandomViewController.swift
//  TRENGDict
//
//  Created by berk birkan on 3.08.2019.
//  Copyright © 2019 berk birkan. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var randomwords = [Word]()
    //var words = [Word]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "random", for: indexPath)
        
        cell.textLabel!.text = self.randomwords[indexPath.row].word
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let alert = UIAlertController(title: self.randomwords[indexPath.row].word, message: randomwords[indexPath.row].mean, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        
        let addfav = UIAlertAction(title: "Add to Favorite", style: UIAlertAction.Style.default) { (deneme) in
            let sozcuk = Word()
            sozcuk.word = self.randomwords[indexPath.row].word
            sozcuk.mean = self.randomwords[indexPath.row].mean
            DBManager.sharedInstance.addData(object: sozcuk)
            
        }
        
        alert.addAction(ok)
        alert.addAction(addfav)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSON()

        tableview.delegate = self
        tableview.dataSource = self
        
        
        
        
    }
    
    func getJSON(){
        
        if let path = Bundle.main.path(forResource: "dictionary", ofType: "json") {
            do {
                let dataResponse = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                print(jsonResponse)
                
                let words = jsonResponse as! [String:Any]
                var i = 0
                for word in words.keys{
                    if i == 10{
                        break
                    }
                    let sozcuk = Word()
                    sozcuk.word = word
                    sozcuk.mean = words[word] as! String
                    self.randomwords.append(sozcuk)
                    i = i + 1
                }
            } catch {
                // handle error
            }
        }
        
    }
    

   

}
