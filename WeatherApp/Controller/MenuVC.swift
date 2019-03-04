//
//  MenuViewController.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var BGImage: UIImageView!
    var menu : [String] = []
    let menuCountry = ["EG", "GB", "FR" , "" ,""]
    

    
    override func viewDidAppear(_ animated: Bool) {
        let BG = UserDefaults.standard.string(forKey: "BG")!
        self.BGImage.image = UIImage(named: BG)
        getMenuItems()
    }
    
    fileprivate func getMenuItems() {
        if (UserDefaults.standard.array(forKey: "menuItems") == nil) {
            UserDefaults.standard.set(menuItems, forKey: "menuItems")
            menu = menuItems
            menuTable.reloadData()
        }else{
            menu = UserDefaults.standard.array(forKey: "menuItems") as! [String]
            menuTable.reloadData()
        }
    }

    
}

extension MenuViewController : UITableViewDataSource , UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = menu[indexPath.row]
        
        if name == "Curent Location" {

            UserDefaults.standard.set("curent", forKey: "location")
            UserDefaults.standard.set("map", forKey: "BG")
            
        }else if name == "Cairo" || name == "London" || name == "Paris"{
            
            UserDefaults.standard.set(name, forKey: "location")
            UserDefaults.standard.set(name, forKey: "BG")
            
        }else{
            UserDefaults.standard.set(name, forKey: "location")
            UserDefaults.standard.set("map", forKey: "BG")
        }
        
        self.performSegue(withIdentifier: "show", sender: nil)
    }

    
}
