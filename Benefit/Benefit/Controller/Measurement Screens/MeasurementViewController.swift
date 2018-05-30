//
//  MeasurementViewController.swift
//  Benefit
//
//  Created by Delta One on 17/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Charts

class MeasurementViewController: UIViewController
{

    @IBOutlet weak var BMIChart: LineChartView!
    @IBOutlet weak var BMRChart: LineChartView!
    @IBOutlet weak var BodyFatChart: LineChartView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViews()

    }

    func setupViews()
    {
        setUp(BMIChart)
        setUp(BMRChart)
        setUp(BodyFatChart)
    }
    
    func setUp(_ chart: LineChartView)
    {
        var chartEntries = [ChartDataEntry]()
        
        for i in 0...31
        {
            let value = Double(arc4random_uniform(10) + 20)
            let point = ChartDataEntry(x: Double(i), y: value)
            chartEntries.append(point)
        }
        
        let lineColor = NSUIColor(red: 76/255, green: 84/255, blue: 232/255, alpha: 1.0)
        let line1 = LineChartDataSet(values: chartEntries, label: nil)
        line1.colors = [lineColor]
        line1.circleRadius = 2.5
        line1.circleColors = [lineColor]
        line1.circleHoleRadius = 0
        
        let data = LineChartData()
        data.addDataSet(line1)
        data.setDrawValues(false)
        
        chart.data = data
        chart.xAxis.labelPosition = .bottom
        chart.drawGridBackgroundEnabled = true
    
        chart.xAxis.granularity = 1.0
        chart.xAxis.labelCount = 31
        chart.xAxis.drawLabelsEnabled = false
        chart.leftAxis.labelCount = 15
        
        chart.legend.enabled = false
        chart.rightAxis.enabled = false
        chart.chartDescription = nil
        
    }

    

}
