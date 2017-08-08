



import Foundation
import Charts

    /*
     *   // This protocol is to set the data in the Marker or Balloon
     ***/
public protocol ChartDataManipulater
{
    // send values that needed to be set
    func getStringForValue(value: Double) -> (Double,Double)
}

    /*
     *   // This Class is to customize Marker or Balloon
     ***/
open class XYMarkerView: BalloonMarker
{
    open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter()
    
    var mAxisValueManipulator : ChartDataManipulater?
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                manipulator: ChartDataManipulater)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        //self.xAxisValueFormatter = xAxisValueFormatter
        mAxisValueManipulator = manipulator
        yFormatter.minimumFractionDigits = 0
        yFormatter.maximumFractionDigits = 2
    }
    
//    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
//    {
//        setLabel("x: " + xAxisValueFormatter!.stringForValue(entry.x, axis: nil) + "\n y: " + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!)
//    }
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let values : (Double, Double) = mAxisValueManipulator!.getStringForValue(value: entry.x)
        setLabel("x: " + yFormatter.string(from: NSNumber(floatLiteral: values.0))! + "\n y: " + yFormatter.string(from: NSNumber(floatLiteral: values.1))!)
    }
}
