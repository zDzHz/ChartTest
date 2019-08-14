//
//  ViewController.swift
//  ChartTest
//
//  Created by Min on 13/08/2019.
//  Copyright © 2019 Seongmin. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    var values: [ChartDataEntry] = []
    
    let array1: [Double] = [3, 1, 2, 2, 1, 3, 1, 3, 1, 2, 2, 1, 3, 1, 3, 1, 2, 2, 1, 3, 1, 3, 1, 2, 2, 1, 3, 1, 3, 1, 2, 2, 1, 3, 1]
    let array2: [Double] = [1]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initChartView()
    }


    func initChartView() {
        self.chartView.delegate = self
        
        self.chartView.drawGridBackgroundEnabled = false
        self.chartView.drawBordersEnabled = true
        self.chartView.setScaleEnabled(false)
        self.chartView.dragEnabled = true
        self.chartView.scaleYEnabled = false
        self.chartView.chartDescription?.enabled = false
        self.chartView.legend.enabled = false
        
        setLeftAxisMinMax(3.5)

        
        self.chartView.rightAxis.enabled = false
        
        let xAxis = self.chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
//        xAxis.granularityEnabled = true
        xAxis.valueFormatter = self     // x축 표현식 바꿈
        xAxis.spaceMax = 2
        xAxis.spaceMin = 2

//        xAxis.axisMinimum = 5
        
//        xAxis.setLabelCount(7, force: true)
        lineChartData(true)
    
        self.chartView?.zoom(scaleX: CGFloat(Double(values.count) / 3), scaleY: 0, xValue: Double(values.count), yValue: 0, axis: .left)
    }
    
    
    func setLeftAxisMinMax(_ max: Double) {
        let leftAxis = chartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawLabelsEnabled = true
        leftAxis.axisMaximum = max
        leftAxis.axisMinimum = 0.5
        leftAxis.granularity = 1
        leftAxis.valueFormatter = self
        setLimieLine()
        
    }
    
    func setLimieLine() {
        let line1 = ChartLimitLine(limit: 1.5)
        line1.lineWidth = 1
        line1.lineColor = .gray
        
        let line2 = ChartLimitLine(limit: 2.5)
        line2.lineWidth = 1
        line2.lineColor = .gray
        
        let midLine = ChartLimitLine(limit: Double(self.chartView.bounds.width / 2))
        midLine.lineWidth = 1
        midLine.lineColor = .red
        midLine.lineDashLengths = [1, 3]
        print(Double(self.chartView.bounds.width / 2))
        
        self.chartView.leftAxis.addLimitLine(line1)
        self.chartView.leftAxis.addLimitLine(line2)
        self.chartView.xAxis.addLimitLine(midLine)
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        values.removeAll()
        self.chartView.zoomOut()
        if sender == btn1 {
            setLeftAxisMinMax(3.5)
            lineChartData(true)
        } else {
            setLeftAxisMinMax(2.5)
            lineChartData(false)

        }

    }
    
    func setColor(_ value: Double) -> UIColor {
        if value == 1 {
            return .red
        } else {
            return .blue
        }
    }
    
    func lineChartData(_ isArr1: Bool) {
        if isArr1 {
            for i in 0..<array1.count {
                values.append(ChartDataEntry(x: Double(i), y: array1[i]))
            }
        } else {
            for i in 0..<array2.count {
                values.append(ChartDataEntry(x: Double(i), y: array2[i]))
            }
        }

        let set = LineChartDataSet(entries: values, label: "")
        let data = LineChartData(dataSet: set)
        data.notifyDataChanged()
        chartView.notifyDataSetChanged()
//        set.colors
        set.highlightColor = .clear
        values.forEach {
            if $0.y > 2 || $0.y < 6 {
                
            }
        }
        
//        data.highlightEnabled = false
        data.setDrawValues(false)
        self.chartView.data = data
    }
}

extension ViewController: ChartViewDelegate, IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if axis == chartView.leftAxis {
            return "양성(3+)"
        } else{
        if value < Double(values.count) && value >= 0 {
            return "title"
        } else {
            return ""
        }
        }
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
}
