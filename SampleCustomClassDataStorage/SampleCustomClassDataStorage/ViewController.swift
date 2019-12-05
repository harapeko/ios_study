//
//  ViewController.swift
//  SampleCustomClassDataStorage
//
//  Created by harapeko on 2019/12/05.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面表示時にデータを格納
        let userDefaults = UserDefaults.standard
        let data = MyData()
        data.valueString = "test"
        
        // シリアライズ処理
        do {
            let archiveData = try NSKeyedArchiver.archivedData(
                    withRootObject: data,
                    requiringSecureCoding: true)

            userDefaults.set(archiveData, forKey: "data")
            userDefaults.synchronize()
            
            // デシリアライズ処理
            if let storeData = userDefaults.object(forKey: "data") as? Data {
                if let unarchiveData = try NSKeyedUnarchiver.unarchivedObject(ofClass: MyData.self, from: storeData) {
                    if let valueString = unarchiveData.valueString {
                        print("シリアライズデータ：" + valueString)
                    }
                }
            }
        } catch {
            print("エラー \(error)")
        }
    }


}

