//
//  StartViewController.swift
//  MyQuiz
//
//  Created by harapeko on 2019/12/15.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 次の画面に繊維される前の準備処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // super.prepare(for: segue, sender: sender)
        // 問題文を読み込む
        QuestionDataManager.sharedInstance.loadQuestion()

        // 遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }

        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得できずに終了
            return
        }

        // 問題文のセット
        nextViewController.questionData = questionData
    }

    // タイトルに戻ってくるとき呼び出される処理
    @IBAction func goToTitle(_ segue: UIStoryboardSegue) {

    }
}
