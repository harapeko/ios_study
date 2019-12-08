//
//  ViewController.swift
//  SampleQuiz
//
//  Created by harapeko on 2019/12/09.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // システムサウンド
    @IBAction func tapSystemSound(_ sender: Any) {
        AudioServicesPlaySystemSoundWithCompletion(1000) {
            print("soundedシステムサウンド")
        }
    }
    
    // カスタムサウンド
    @IBAction func tapCustomSound(_ sender: Any) {
        let soundUrl = Bundle.main.url(forResource: "custom", withExtension: "mp3")
        // サウンドIDを登録するための変数を用意する
        var soundId: SystemSoundID = 0
        // サウンドファイルを登録してサウンドIDを取得
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundId)
        // 取得したサウンドIDを使用してサウンドを鳴らす
        AudioServicesPlaySystemSoundWithCompletion(soundId) {
            print("soundedカスタムサウンド")
        }
    }
    
    
    @IBAction func tapVibration(_ sender: Any) {
        // バイブレーションのみ発生させる
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            print("soundedバイブレーション")
        }
    }
}

