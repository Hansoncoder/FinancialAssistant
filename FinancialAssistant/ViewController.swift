//
//  ViewController.swift
//  FinancialAssistant
//
//  Created by Hanson on 2018/4/14.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, InputViewDelegate {

    @IBOutlet weak var resultView: ResultView!
    @IBOutlet weak var myinputView: InputView!

    private var tipText: String?
    @IBOutlet weak var tipLabel: UILabel!

    // MARK: - system

    override func viewDidLoad() {
        super.viewDidLoad()
        tipText = tipLabel.text
        myinputView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


    private func setupTipText(text: String) {

        let showColor = UIColor.init(red: 0, green: 131/255.0,
                                     blue: 1, alpha: 1)
        tipLabel.text = text.count > 0 ? text : tipText
        tipLabel.textColor = text.count > 0 ? UIColor.red : showColor
    }

    // MARK: - 计算

    func inputViewEndInput() {
        calculate(nil)
    }

    @IBAction func calculate(_ sender: UIButton?) {
        let currentInterestRate = myinputView.currentInterestRate()
        let investmentRate = myinputView.investmentRate()
        let investmentDay = myinputView.investmentDay()

        calculateAndShowProfitMoney(current: currentInterestRate,
                                    investmentRate: investmentRate,
                                    investmentDay: investmentDay)

        calculateAndShowInvestmentDay(current: currentInterestRate,
                                      investmentRate: investmentRate)

        calculateAndShowInvestmentRateLabel(current: currentInterestRate,
                                            investmentDay: investmentDay)

    }

    // MARK: - 结果显示

    private func calculateAndShowProfitMoney(current currentInterestRate: Double,
                                             investmentRate: Double,
                                             investmentDay: Int) {

        var tempText = ""
        var day = investmentDay
        if investmentDay == 0 {
            day = 3
            tempText += "没有输入投资天数，默认投资3天";
        }

        var investmentMoney = myinputView.investmentMoney()
        if investmentMoney == 0 {
            investmentMoney = 10000
            tempText = tempText.count > 0 ? tempText + "\n":""
            tempText += "没有输入投资投资金额，默认为投资1万";
        }
        let profitMoney = calculateEarnMoney(from: currentInterestRate,
                                             to: investmentRate,
                                             day: day,
                                             money: investmentMoney)
        resultView.setProfit(text: profitMoney)

        setupTipText(text: tempText)
    }

    private func calculateAndShowInvestmentDay(current currentInterestRate: Double,
                                               investmentRate: Double) {
        let investmentDay = calculateInvestmentDay(from: currentInterestRate,
                                                   to: investmentRate)
        resultView.setInvestmentDay(day: investmentDay)
    }

    private func calculateAndShowInvestmentRateLabel(current currentInterestRate: Double,
                                                     investmentDay: Int) {

        let day = (0 == investmentDay) ? 3 : investmentDay
        let ivestmentRate = calculateInterestRate(rate: currentInterestRate,
                                                  day: day)
        resultView.investmentRate(rate: ivestmentRate)

    }

    // MARK: - 算法

    /// 计算最低投资天数
    ///
    /// - Parameters:
    ///   - firstInterestRate: 持有利率
    ///   - secondInterestRate: 准备投资的利率
    /// - Returns: 最少投资天数(当投资利率低于持有利率，返回0)
    private func calculateInvestmentDay(from firstInterestRate: Double,to secondInterestRate: Double) -> Int {
        if firstInterestRate >= secondInterestRate {
            return 0
        }
        let leastDay = ceil(2 * firstInterestRate / (secondInterestRate - firstInterestRate))
        return Int(leastDay)
    }


    /// 计算最低利率
    ///
    /// - Parameters:
    ///   - firstInterestRate: 当前投资利率
    ///   - investmentDay: 转投投资天数
    /// - Returns: 转投最低利率
    private func calculateInterestRate(rate firstInterestRate: Double, day investmentDay: Int) -> Double {
        return firstInterestRate * Double((investmentDay + 2)) / Double(investmentDay)
    }

    private func calculateEarnMoney(from firstInterestRate: Double, to secondInterestRate: Double,day investmentDay: Int, money: Double = 10000) -> Double {
        let firstInterest = firstInterestRate * Double((investmentDay + 2)) / 36500.0
        let secondInterest = secondInterestRate * Double(investmentDay) / 36500.0
        let earnMoney = (secondInterest - firstInterest) * money
        return earnMoney
    }

}

