//
//  ViewController.swift
//  SampleDataStorage
//
//  Created by harapeko on 2019/12/05.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()
        // UserDefaultsを参照する
        let userDefaults = UserDefaults.standard
        
        // textというキーを指定して保存していた値を取り出す
        if let value = userDefaults.string(forKey: "text") {
            // 取り出した値をテキストフィールドに設定
            textField.text = value
        }
    }

    @IBAction func tapActionButton(_ sender: Any) {
        // userDefaultsの参照
        let userDefaults = UserDefaults.standard
        // textというキーで値を保存する
        userDefaults.set(textField.text, forKey: "text")
        // UserDefaultsへの値の保存を明示的に行う
        userDefaults.synchronize()
    }
}
