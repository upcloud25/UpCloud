//
//  AddViewController.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage



class AddViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    var tableArray =  [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if UserDefaults.standard.bool(forKey: "firstTime") {
            loadData()
        }else{
            UserDefaults.standard.set(true, forKey: "firstTime")
            Connections().getAll { (Country) in
                for item in Country {
                    let city = City(context: self.managedObjectContext)
                    city.name = item.city
                    city.code = item.code
                    city.flag = item.image
                    city.country = item.name
                    
                    do {
                     try self.managedObjectContext.save()
                    }catch {
                    print("can not save data cuz \(error.localizedDescription)")
                    }
                }
                self.loadData()
            }
        }
       
    }
    
    func loadData() {
        
        let cityRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            tableArray = try managedObjectContext.fetch(cityRequest)
            self.tableView.reloadData()
        }catch{
            print("can not featching\(error.localizedDescription)")
            self.dismiss(animated: true, completion: nil)
        }
    
    }

    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

   
}

extension AddViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddTableViewCell
        
        let singleCity = tableArray[indexPath.row]
        
        if singleCity.name == "" {
            cell.cityName.text = singleCity.country
        }else{
            cell.cityName.text = singleCity.name
        }
        
        cell.cityCountry.text =  singleCity.country! + "," +  singleCity.code!
        
        let code = singleCity.code?.lowercased()
        
        let url = URL(string: "https://flagpedia.net/data/flags/normal/\(code!).png")
        
        cell.cityImage.sd_setImage(with: url!)
        
        if cell.cityImage.image == nil {
            cell.cityImage.image = #imageLiteral(resourceName: "no")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let singleCity = tableArray[indexPath.row]
        
        let  cityName = singleCity.name!
        
        if (UserDefaults.standard.array(forKey: "menuItems") == nil) {
            
            guard !menuItems.contains(cityName) else {return}
            menuItems.insert(cityName, at: 0)
            
            UserDefaults.standard.set(menuItems, forKey: "menuItems")
            
        }else{
            
            var menu = UserDefaults.standard.array(forKey: "menuItems") as! [String]
            if menu.contains(cityName) {
                return
            }
            menu.insert(cityName, at: 0)
            UserDefaults.standard.set(menu, forKey: "menuItems")
        }
        
        managedObjectContext.delete(tableArray[indexPath.row])
        
        do {
            try self.managedObjectContext.save()
        }catch {
            print("can not save data cuz \(error.localizedDescription)")
        }
    }
}
