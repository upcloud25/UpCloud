//
//  ViewController.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import UIKit
import SWRevealViewController
import CoreLocation
import GoogleMobileAds

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var BGImage: UIImageView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weather_main: UILabel!
    @IBOutlet weak var weather_desc: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var cloud: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    var lat = ""
    var long = ""
    let locationManger = CLLocationManager()
    var location = CLLocation()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAdMop()

        setupLocationManger()
       
        setupMenu()
        
        setData()
    }



    @IBAction func AddNewCity(_ sender: Any) {

    }

    func AnimateImage(_ image: UIImageView )  {
     UIView.animate(withDuration: 9, animations: {
        image.center.x = self.view.center.x - 300
     }) { (true) in
        UIView.animate(withDuration: 9, animations: { image.center.x = self.view.center.x + 300 }) {(true) in
            self.AnimateImage(image)
        }
        }
    }
    
    fileprivate func setData() {
        let city = UserDefaults.standard.string(forKey: "location")!
        let BG = UserDefaults.standard.string(forKey: "BG")!
        self.BGImage.image = UIImage(named: BG)
        AnimateImage(BGImage)
        if city == "curent"{
            locationManger.startUpdatingLocation()
        }else{
            Connections().getWeater(city: city) { (Weather) in
                if let curentWeather = Weather {
                    DispatchQueue.main.async {
                        self.temp.text = "\(curentWeather.temp!)"
                        self.cityName.text = curentWeather.name!
                        self.weather_desc.text = curentWeather.weather_description!
                        self.weather_main.text = curentWeather.weather_main!
                        self.maxTemp.text = curentWeather.temp_max! + "˚"
                        self.minTemp.text = curentWeather.temp_min! + "˚"
                        self.cloud.text = curentWeather.clouds! + "%"
                        self.windSpeed.text = curentWeather.wind_speed! + "m/s"
                        self.humidity.text = curentWeather.humidity! + "%"
                        self.country.text = curentWeather.name! + "," + curentWeather.country!
                        self.sunrise.text = curentWeather.sunrise!
                        self.sunset.text = curentWeather.sunset!
                        self.date.text = curentWeather.date!
                    }
                    
                }
            }
            
        }
    }
    
    fileprivate func setupMenu() {
        if self.revealViewController() != nil {
            self.settingBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    fileprivate func setupLocationManger() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    fileprivate func setupAdMop() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.adUnitID = "ca-app-pub-7594572719756466/7792665390"
        bannerView.rootViewController = self
        bannerView.load(request)
    }

}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = CLLocation(latitude: (locations.last!.coordinate.latitude) , longitude: (locations.last!.coordinate.longitude))
        
        locationManger.stopUpdatingLocation()
        lat = "\(location.coordinate.latitude)"
        long = "\(location.coordinate.longitude)"
        
        Connections().getWeaterWithLocation(latitude: lat , longitude: long) { (Weather) in
            if let curentWeather = Weather {
                DispatchQueue.main.async {
                    self.temp.text = "\(curentWeather.temp!)"
                    if curentWeather.name == "testing"{
                        self.cityName.text = "--"
                        self.country.text = "--" + curentWeather.country!
                    }else{
                        self.cityName.text = curentWeather.name!
                        self.country.text = curentWeather.name! + "," + curentWeather.country!
                    }
                    self.weather_desc.text = curentWeather.weather_description!
                    self.weather_main.text = curentWeather.weather_main!
                    self.maxTemp.text = curentWeather.temp_max! + "˚"
                    self.minTemp.text = curentWeather.temp_min! + "˚"
                    self.cloud.text = curentWeather.clouds! + "%"
                    self.windSpeed.text = curentWeather.wind_speed! + "m/s"
                    self.humidity.text = curentWeather.humidity! + "%"
                    self.sunrise.text = curentWeather.sunrise!
                    self.sunset.text = curentWeather.sunset!
                    self.date.text = curentWeather.date!
                }
                
            }
        }
        
        
    }
}
