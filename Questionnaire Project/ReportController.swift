//
//  ReportController.swift
//  Questionnaire Project
//
//  Created by Andrew on 2016/11/9.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import SnapKit
import SwiftCharts

class ReportController: BaseController {

    fileprivate var chart: Chart? // arc
    
    private let sideSelectorHeight: CGFloat = 50
    private var tipLb:UILabel!
    private var descLb:UILabel!
    
    /// 报表的数据
    var arrayData:[resultTuple]?
    var xTitle:String = "Answer"
    var yTitle:String = "Count"
    var descString:String = ""
    
    private var minValue:Int!
    private var maxValue:Int!
    
    /// 纵坐标的分割值
    private var splitValue:Int!
    //总共参与人数
    private var totalCountOfPerson:Int = 0
    
    fileprivate func chart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
    
        let color3 = COLOR_BG
        
        let zero = ChartAxisValueDouble(0)
        var barModels = [ChartStackedBarModel]()
        
        var orderIndex = 1
        for item in arrayData! {
          let name = item.name
          let value = Double(item.value)
          let model =  ChartStackedBarModel(constant: ChartAxisValueString(name, order: orderIndex, labelSettings: labelSettings), start: zero, items: [
                                ChartStackedBarItemModel(quantity: value, bgColor: color3)
                                ])
            barModels.append(model)
            orderIndex += 1
        }
        

        let (axisValues1, axisValues2) = (
            stride(from: 0, through: maxValue, by: splitValue).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: 5, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: xTitle, settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: yTitle, settings: labelSettings.defaultVertical()))
        
        let frame = ExamplesDefaults.chartFrame(self.view.bounds)
        let chartFrame = self.chart?.frame ?? CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height - sideSelectorHeight-50)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 30, animDuration: 0.5)
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)

        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
    
    
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.chart(horizontal: horizontal)
        self.view.addSubview(chart.view)
        self.chart = chart
        
        self.chart?.view.contentMode = .redraw
        
        self.chart?.view.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(64)
            make.bottom.equalTo(-50)
            make.right.equalTo(0)
        })
    }
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.titlelb.text = "Bar Charts"
        
        if arrayData?.count == 0{
            QuestionUtil.showAlert(title: "No Data", vc: self)
          return
        }
        //计算获得数据的最大值和最小值
        calculateValue()
        
        
        self.showChart(horizontal: false)
        
        self.view.backgroundColor = UIColor.white
        initTipLb(title: "总共参与答题人数:\(totalCountOfPerson)")
    }
    
    func initTipLb(title:String) -> Void {
        tipLb = UILabel()
        tipLb.textAlignment = .center
        tipLb.textColor = UIColor.red
        tipLb.text = title
        tipLb.font = UIFont.boldSystemFont(ofSize: 17)
        
        tipLb.backgroundColor = UIColor.yellow
        self.view.addSubview(tipLb)
        
        tipLb.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(50)
            make.right.equalTo(0)
        }
        
        
        descLb = UILabel()
        descLb.isHidden = descString.isEmpty ? true:false
        descLb.backgroundColor = UIColor(red: 215/255, green: 229/255, blue: 184/255, alpha: 1)
        descLb.text = descString
        descLb.sizeToFit()
        descLb.textColor = UIColor.red
        descLb.lineBreakMode = .byCharWrapping
        descLb.numberOfLines = 0
        self.view.addSubview(descLb)
        
        descLb.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(tipLb.snp.top)
            make.height.equalTo(50)
            make.right.equalTo(0)
        }
    }
    
    func calculateValue() -> Void {
        var arrayValue = [Int]()
        
        for item in arrayData! {
            let value = item.value
            arrayValue.append(value)
            totalCountOfPerson += value
        }
        minValue = arrayValue.min()
        maxValue = arrayValue.max()
        maxValue = maxValue + maxValue/5
        maxValue = maxValue == 1 ? 2 : maxValue
        
        splitValue = maxValue/5
        
        splitValue = min(splitValue, minValue)
        splitValue = splitValue == 0 ? 1 : splitValue
        
    }
    


}
