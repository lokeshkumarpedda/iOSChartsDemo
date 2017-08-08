//
//  ViewController.swift
//  ChartsDemo
//
//  Created by Next on 17/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import Charts
class ViewController: UIViewController {
    
    @IBOutlet weak var mBarChartView: BarChartView!

    var mMonths : [String]?
    var mAverage : Double?
    var mValues : [Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mMonths = ["A","B","C","D","F","G","H","I","J","K","L","M"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mAverage = 50
        mValues = [20,40.0,0,50,10,100,55,80,40,10.50,80,35]
        mBarChartView.delegate = self
        setChart(dataPoints: mMonths!, values: mValues!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // For setting up the data and customizing the Chart
    private func setChart(dataPoints :[String] , values : [Double])
    {
        var dataEntries : [BarChartDataEntry] = []
        var colors : [UIColor] = []
        let belowAverageColor : UIColor = UIColor.blue
        let aboveAverageColor : UIColor = UIColor.blue.withAlphaComponent(0.5)
        let averageColor : UIColor = UIColor.lightGray
        
        for i in 0..<dataPoints.count
        {
            let eachValue : Double = values[i]
            var entry : BarChartDataEntry?
            if eachValue == 0
            {
                entry = BarChartDataEntry.init(x: Double(i), yValues: [mAverage!])
                colors.append(averageColor)
            }
            else if eachValue <= mAverage!
            {
                entry = BarChartDataEntry.init(x: Double(i), yValues: [eachValue,mAverage!-eachValue])
                colors.append(belowAverageColor)
                colors.append(averageColor)
                
//                entry = BarChartDataEntry.init(x: Double(i), yValues: [eachValue])
//                colors.append(belowAverageColor)
            }
            else
            {
                entry = BarChartDataEntry.init(x: Double(i), yValues: [mAverage!,eachValue-mAverage!])
                colors.append(belowAverageColor)
                colors.append(aboveAverageColor)
            }
            dataEntries.append(entry!)
        }
        
        let dataSet = BarChartDataSet.init(values: dataEntries, label: "")
        
        // removed value on top of each bar
        dataSet.drawValuesEnabled = false
        
        // removing the highlight on bar tapped
        dataSet.highlightAlpha = 0
        
        
        // assigning colors to bar
        dataSet.colors = colors
        let data = BarChartData(dataSet: dataSet)
    
        mBarChartView.data = data
        
        // Skipping labels in between
        mBarChartView.xAxis.setLabelCount(mMonths!.count, force: false)
        
        // setting data on X axis
        mBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter.init(values: mMonths!)
        
        // color of labels on xaxis
        mBarChartView.xAxis.labelTextColor = UIColor.black
        
        
        // setting maximum value of the graph
        mBarChartView.leftAxis.axisMaximum =  100
        mBarChartView.rightAxis.axisMaximum = 100
        mBarChartView.leftAxis.axisMinimum = 0.0
        mBarChartView.rightAxis.axisMinimum = 0.0
        
        // removing grid lines
        mBarChartView.leftAxis.drawGridLinesEnabled = false
        mBarChartView.rightAxis.drawGridLinesEnabled = false
        mBarChartView.xAxis.drawGridLinesEnabled = false
        
        // removing left and right axis
        mBarChartView.leftAxis.enabled = false
        mBarChartView.rightAxis.enabled = false
        
        // removing bottom line
        mBarChartView.xAxis.drawAxisLineEnabled = false
        
        // Emptying the description label
        mBarChartView.chartDescription?.text = ""
        
        // placing the X axis label to bottom
        mBarChartView.xAxis.labelPosition = .bottom
        
        // bottom information about the bars is hidden
        mBarChartView.legend.enabled = false
        
        // Disabling the Zooming
        mBarChartView.doubleTapToZoomEnabled = false
        mBarChartView.pinchZoomEnabled = true
        mBarChartView.scaleXEnabled = true
        mBarChartView.scaleYEnabled = false
        
        // removing the shadow
//        mBarChartView.drawBarShadowEnabled = false
        mBarChartView.setVisibleXRange(minXRange: 6, maxXRange: 12)
        mBarChartView.highlightFullBarEnabled = true
        mBarChartView.animate(yAxisDuration: 1, easingOption: .easeInQuad)
        
    }
}
extension ViewController : ChartViewDelegate , ChartDataManipulater
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
extension ChartHighlighter
{
}
