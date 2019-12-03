//
//  ResultViewController.swift
//  MyCalc
//
//  Created by harapeko on 2019/12/03.
//  Copyright © 2019 harapeko. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var price: Int = 0

    let percentValue: Float = 0.1

    @IBOutlet weak var resultField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 割引額を算出する
        let waribikiPrice = Float(price) * percentValue
        // 割引後の価格を算出する
        let percentOffPrice = price - Int(waribikiPrice)
        // 結果を表示する
        resultField.text = "\(percentOffPrice)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
