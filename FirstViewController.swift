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

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    var filtered = [Word]()
    var words = [Word]()
    var issearching = false
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        issearching = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        issearching = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        issearching = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //self.words.removeAll()
        
        
        filtered = filterWord(text: searchText)
        if(filtered.count == 0){
            issearching = false;
        } else {
            issearching = true;
        }
        self.tableview.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        issearching = false
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(issearching) {
            return filtered.count
        }
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dict", for: indexPath)
        
        
        if issearching{
            cell.textLabel!.text = filtered[indexPath.row].word
        }else{
            cell.textLabel!.text = words[indexPath.row].word
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if issearching{
            let alert = UIAlertController(title: filtered[indexPath.row].word, message: filtered[indexPath.row].mean, preferredStyle: UIAlertController.Style.alert)
            
            let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            
            let addfav = UIAlertAction(title: "Add to Favorite", style: UIAlertAction.Style.default) { (deneme) in
                let sozcuk = Word()
                sozcuk.word = self.filtered[indexPath.row].word
                sozcuk.mean = self.filtered[indexPath.row].mean
                DBManager.sharedInstance.addData(object: sozcuk)
                
            }
            
            alert.addAction(ok)
            alert.addAction(addfav)
            
            self.present(alert, animated: true, completion: nil)
        }else{
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
        
       
        
    }
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getJSON()
        tableview.delegate = self
        tableview.dataSource = self
        
        searchbar.delegate = self
        
    }
    
    
    func getJSON(){
        
        if let path = Bundle.main.path(forResource: "dictionary", ofType: "json") {
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
    
    func filterWord(text: String)->[Word] {
        var filteredwords = [Word]()
        for word in words{
            if word.word.contains(text){
                filteredwords.append(word)
            }
        }
        
        return filteredwords
        
    }
    
    

    
    
    
    


}

