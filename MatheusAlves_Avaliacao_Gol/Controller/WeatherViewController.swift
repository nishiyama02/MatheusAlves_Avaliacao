//
//  WeatherViewController.swift
//  MatheusAlves_Avaliacao_Gol
//
//  Created by matheus.n.alves on 29/06/2018.
//  Copyright © 2018 matheus.n.alves. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var locations: [Location]!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.setupTableView()
        
    }
    
    private func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.updateFooterView()
    }
    
    fileprivate func getWeatherDetail(forLocation location: Location)
    {
        let backgroundQueue = DispatchQueue(label: "backgroundQueue", qos: DispatchQoS.background)
        backgroundQueue.async {
            WeatherService.instance.getWeatherDetail(withWoeId: location.woeId, getWeatherDetailHandler: {
                [unowned me = self] (success, weathers, message) in
                if success {
                    DispatchQueue.main.async {
                        if let index = me.locations.index(of: location){
                            me.locations[index].weathers = weathers
                            if let cell = me.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as? WeatherCell{
                                cell.updateWeather(me.locations[index].getTodayWeather())
                            }
                        }
                    }
                }
            })
        }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let locations = self.locations{
            return locations.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: WeatherCell.INDENTIFIER, for: indexPath) as! WeatherCell
        let location = self.locations[indexPath.row]
        cell.updateLocation(location)
        cell.selectionStyle = .none
        return cell
    }

    
}
    
    

