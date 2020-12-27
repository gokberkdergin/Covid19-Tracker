//
//  ViewController.swift
//  COVID-19TURKEY
//
//  Created by Gökberk on 22.12.2020.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var totalconfirmedLabel: UILabel!
    @IBOutlet weak var totaldeathLabel: UILabel!
    @IBOutlet weak var totalrecoveredLabel: UILabel!
    
    @IBOutlet weak var todayrecoveredLabel: UILabel!
    
    
    @IBOutlet weak var todayconfirmedLabel: UILabel!
    @IBOutlet weak var todaydeathLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        getdata()
        
        
    }
    
    
    func getdata() {
        
        //1 Request & Session
        //2 Response & Data
        //3 Parsing Json
       
        //https://api.covid19api.com/summary
        let url = URL(string: "https://api.covid19api.com/summary")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error!!", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            else {
                
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        
                        DispatchQueue.main.async {
                            
                        
    
                            if let global = jsonResponse["Global"] as? [String : Any] {
                            
                                print(global)
                            if let totaldeaths = global["TotalDeaths"] as? Int {
                                self.totaldeathLabel.text = "Total Deaths:      \(totaldeaths)"
                            }
                                
                            if let totalrecovered = global["TotalRecovered"] as? Int {
                                self.totalrecoveredLabel.text = "Total Recovered:   \(totalrecovered)"
                                }
                                
                            if let totalconfirmed = global["TotalConfirmed"] as? Int {
                                self.totalconfirmedLabel.text = "Total Confirmed:                   \(totalconfirmed)"
                                }
                            if let newconfirmed = global["NewConfirmed"] as? Int {
                                print(newconfirmed)
                                self.todayconfirmedLabel.text = "Today Confirmed:                       \(newconfirmed)"
                                    }
                                if let newdeaths = global["NewDeaths"] as? Int {
                                   self.todaydeathLabel.text = "Today Deaths:     \(newdeaths)"
                                        }
                                if let newrecovered = global["NewRecovered"] as? Int {
                                    self.todayrecoveredLabel.text = "Today Recovered:     \(newrecovered)"
                                        }
                                
                                
                                
                                
                            }
                            
                        }
                        
                        
                        
                    }
                    catch {
                        
                    }
                }
                
                
                
            }
            
            
        }
        
        task.resume()
    }
    
    
   
    @IBAction func refresh(_ sender: Any) {
        getdata()
    }
    

}
