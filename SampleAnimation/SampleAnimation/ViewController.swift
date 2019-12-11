//
//  ViewController.swift
//  SampleAnimation
//
//  Created by harapeko on 2019/12/10.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        // ビューの角を丸める処理をアニメーションで実現する
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.default)
        
        // 変更前の値は0
        animation.fromValue = 0
        // 変更語の値は20
        animation.toValue = 20
        // アニメーションの時間は1秒
        animation.duration = 1
        // アニメーションをレイヤーに追加する
        targetView.layer.add(animation, forKey: "cornerRadius")
        // 変更語も角丸を維持
        targetView.layer.cornerRadius = 20
        
//        self.targetView.alpha = 1
        // animateメソッドでできることは限られるが、
        // しゅっとかける。変化前の値がデフォ値なら明示不要な気がする
        UIView.animate(withDuration: 2.0) {
            self.targetView.alpha = 0
        }
    }
}

