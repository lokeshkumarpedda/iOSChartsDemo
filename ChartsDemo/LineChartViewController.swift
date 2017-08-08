//
//  LineChartViewController.swift
//  ChartsDemo
//
//  Created by Next on 29/06/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {

    var mMonths : [String]?
    var mAverage : Double?
    var mValues : [Double]?
    
    @IBOutlet weak var mLineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mAverage = 50
        mMonths = ["A","B","C","D","F","G","H"]
        mValues = [80,40,50,60,80,50,40]
        mLineChartView.delegate = self
        setChart(dataPoints: mMonths!, values: mValues!)
        // Do any additional setup after loading the view.
    }

    // For setting up the data and customizing the Chart
    private func setChart(dataPoints :[String] , values : [Double])
    {
        
        var dataEntries : [ChartDataEntry] = []
        for i in 0..<dataPoints.count
        {
            let eachValue : Double = values[i]
            let entry  = ChartDataEntry.init(x: Double(i), y: eachValue)
            dataEntries.append(entry)
        }
        
        let dataSet = LineChartDataSet.init(values: dataEntries, label: "")
        // removed value on top of each bar
        dataSet.drawValuesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 1.75
        dataSet.circleRadius = 3.0
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
       
        
        let gradientColors = [UIColor.cyan.cgColor , UIColor.clear.cgColor]
        let colorLocations : [CGFloat] = [1,0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: colorLocations)
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 100.0)
        dataSet.drawFilledEnabled = true
        
//        dataSet.fillColor = UIColor.init(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        
        dataSet.highlightColor = UIColor.white
        dataSet.cubicIntensity = 0.5
        dataSet.drawCirclesEnabled  = false
        dataSet.axisDependency = .left
        dataSet.lineCapType = .round
        
        let data = LineChartData.init(dataSet: dataSet)
        mLineChartView.data = data
        customizeChart()
    }
    
    private func customizeChart()
    {
//        mLineChartView.backgroundColor = UIColor.init(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        mLineChartView.drawGridBackgroundEnabled = false
        
        mLineChartView.drawBordersEnabled = false
        
        mLineChartView.chartDescription?.enabled = false
        
        mLineChartView.pinchZoomEnabled = false
        mLineChartView.dragEnabled = true
        mLineChartView.setScaleEnabled(true)
        
        mLineChartView.legend.enabled = false
        mLineChartView.dragEnabled = false
        
        // removing grid lines
        mLineChartView.rightAxis.drawGridLinesEnabled = false
        mLineChartView.leftAxis.drawAxisLineEnabled = false
        mLineChartView.leftAxis.drawGridLinesEnabled = false
        mLineChartView.leftAxis.drawZeroLineEnabled = false
        mLineChartView.rightAxis.enabled = false
        mLineChartView.leftAxis.centerAxisLabelsEnabled = true
        mLineChartView.leftAxis.axisLineDashPhase = 0.5
//        mLineChartView.leftAxis.enabled = false
        
        mLineChartView.xAxis.drawAxisLineEnabled = false
        mLineChartView.xAxis.labelPosition = .bottom
        mLineChartView.xAxis.drawGridLinesEnabled = false
//        mLineChartView.xAxis.enabled = false
        // setting maximum value of the graph
        mLineChartView.leftAxis.axisMaximum =  100
        mLineChartView.rightAxis.axisMaximum = 100
        mLineChartView.leftAxis.axisMinimum = 0.0
        mLineChartView.rightAxis.axisMinimum = 0.0
        mLineChartView.xAxis.axisMinimum = 0
        
    }

}
extension LineChartViewController : ChartViewDelegate , ChartDataManipulater
{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        print(entry.description)
        let marker = XYMarkerView.init(color: UIColor.white, font: UIFont.systemFont(ofSize: 12), textColor: UIColor.black, insets: UIEdgeInsets(top: 3, left: 0, bottom: 1, right: 0), manipulator: self)
        
        marker.minimumSize = CGSize(width: 75.0, height: 50.0)
        chartView.marker = marker
    }
    func getStringForValue(value: Double) -> (Double,Double)
    {
        let x : Double = value
        let y : Double = mValues![Int(value)]
        return (x,y)
    }
}
