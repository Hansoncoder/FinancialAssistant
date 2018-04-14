//
//  ResultView.swift
//  FinancialAssistant
//
//  Created by Hanson on 2018/4/14.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit

class ResultView: UIView {

    @IBOutlet weak var profitTitleLabel: UILabel!
    @IBOutlet weak var profitLabel: UILabel!

    @IBOutlet weak var investmentDayLabel: UILabel!
    @IBOutlet weak var investmentRateLabel: UILabel!

    func setProfit(text: Double) {
        profitLabel.text = String.init(format: "%.4f", text)
        let profitColor = text < 0 ? UIColor.red : UIColor.white
        profitLabel.textColor = profitColor
        profitTitleLabel.textColor = profitColor
    }

    func setInvestmentDay(day: Int) {
        investmentDayLabel.text = "\(day)"
    }

    func investmentRate(rate: Double) {
        investmentRateLabel.text = String.init(format: "%.4f", rate)
    }
}
