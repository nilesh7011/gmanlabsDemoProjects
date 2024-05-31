//
//  BarViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import UIKit
import Charts

class BarViewController: UIViewController, ChartViewDelegate {

    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        barChart.delegate = self
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        view.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10{
            
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
            
        }
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        let viewC = (self.storyboard?.instantiateViewController(withIdentifier: "ViewController")) as! ViewController
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    

}
