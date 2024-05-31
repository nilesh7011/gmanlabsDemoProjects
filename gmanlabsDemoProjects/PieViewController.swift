//
//  PieViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import UIKit
import Charts

class PieViewController: UIViewController, ChartViewDelegate {

    var piechart = PieChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        piechart.delegate = self

    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        piechart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        piechart.center = view.center
        view.addSubview(piechart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<10{
            
            entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
            
        }
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        
        let data = PieChartData(dataSet: set)
        piechart.data = data
    }

}
