//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by harapeko on 2019/12/19.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    var questionData: QuestionData!

    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!

    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初期データ設定処理。前画面から受け取ったデートをセットする
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        questionTextView.text = questionData.question
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)
    }

    // 選択肢1をタップ
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        goNextQuestionWithAnimation()
    }

    // 選択肢2をタップ
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        goNextQuestionWithAnimation()
    }

    // 選択肢3をタップ
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        goNextQuestionWithAnimation()
    }

    // 選択肢4をタップ
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        goNextQuestionWithAnimation()
    }

    // 次の問題にアニメーション付きで進む
    func goNextQuestionWithAnimation() {
        // 正解、不正解によって処理を分岐する
        questionData.isCorrect()
            ? goNextQuestionWithCorrectAnimation()
            : goNextQuestionWithIncorrectAnimation()
    }

    // 次の問題に正解のアニメーション付きで進む
    func goNextQuestionWithCorrectAnimation() {
        // 正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)

        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // 正解画像を表示する(Storyboardでは0.0に設定済み)
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }
    }

    // 次の問題に不正解のアニメーション付きで進む
    func goNextQuestionWithIncorrectAnimation() {
        // 不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1006)

        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // 正解画像を表示する(Storyboardでは0.0に設定済み)
            self.incorrectImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }
    }

    // 次の問題へ遷移する
    func goNextQuestion() {
        // 問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 問題文がなければ結果画面へ遷移する
            // StoryboardのIdentifierに設定した値(result)を指定して
            // ViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                // StoryboardのSegueを利用しない明示的な画面遷移処理
                present(nextQuestionViewController, animated: true, completion: nil)
            }
        }
    }
}
