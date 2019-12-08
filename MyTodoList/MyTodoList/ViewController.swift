//
//  ViewController.swift
//  MyTodoList
//
//  Created by harapeko on 2019/12/06.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // TODOを格納する配列
    var todoList = [MyTodo]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 保存しているTODOの読み込み処理
        let userDefaults = UserDefaults.standard
        if let storedTodoList =  userDefaults.object(forKey: "todoList") as? Data {
            do {
                if let unarchiveTodoList =  try NSKeyedUnarchiver.unarchivedObject(
                    ofClasses: [NSArray.self, MyTodo.self], from: storedTodoList) as? [MyTodo] {
                    todoList.append(contentsOf: unarchiveTodoList)
                }
            } catch {
                // エラー処理なし
            }
        }
    }


    // +ボタンを押した時に呼ばれる処理
    @IBAction func tapAddButton(_ sender: Any) {
        // アラートダイアログを生成
        let alertController = UIAlertController(title: "TODO追加",
                                                message: "TODOを入力してください",
                                                preferredStyle: UIAlertController.Style.alert)

        // テキストエリア追加
        alertController.addTextField(configurationHandler: nil)

        // OKボタン追加
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertAction.Style.default) { (action: UIAlertAction) in

            // OKボタンがタップされたときの処理
            if let textField = alertController.textFields?.first {
                // TODO配列に入力値を挿入する
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                self.todoList.insert(myTodo, at: 0)
                // 行が追加されたことをTable Viewに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                          with: UITableView.RowAnimation.right)
                // TODOの保存処理
                let userDefauts = UserDefaults.standard
                // Data型にシリアライズする
                do {
                    let data = try NSKeyedArchiver.archivedData(
                        withRootObject: self.todoList, requiringSecureCoding: true)
                    userDefauts.set(data, forKey: "todoList")
                    userDefauts.synchronize()
                } catch {
                    // エラー処理なし
                }
            }
        }

        // OKボタンがタップされたときの処理
        alertController.addAction(okAction)

        // CANCELボタンがタップされたときの処理
        let cancelButton = UIAlertAction(title: "CANCEL",
                                         style: UIAlertAction.Style.cancel,
                                         handler: nil)
        // CANCELボタンを追加
        alertController.addAction(cancelButton)
        // アラートダイアログを表示
        present(alertController, animated: true, completion: nil)
    }

    // テーブルの行数を返却する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO配列の長さを返却
        todoList.count
    }

    // テーブルの行ごとのセルを返却する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // storyboadで設定したtodoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)

        // 行番号に合ったTODOの情報を取得
        let myTodo = todoList[indexPath.row]
        // セルのラベルにTodoのタイトルをセット
        cell.textLabel?.text = myTodo.todoTitle
        // セルのチェックマーク状態をセット
        if myTodo.todoDone {
            // チェックあり
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        return cell
    }

    // セルをタップしたときの処理
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let myTodo =  todoList[indexPath.row]
        // 完了状態を更新
        myTodo.todoDone = !myTodo.todoDone
        // セルの状態を変更
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        // データ保存。Data型にシリアライズする
        do {
            let data: Data = try NSKeyedArchiver.archivedData(
                withRootObject: todoList, requiringSecureCoding: true)
            // UserDeefaultsに保存
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "todoList")
            userDefaults.synchronize()
        } catch {
            // エラー処理なし
        }
    }

    // セルを削除したときの処理
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 削除処理かどうか
        if editingStyle == UITableViewCell.EditingStyle.delete {
            // TODOリストから削除
            todoList.remove(at: indexPath.row)

            // セル削除
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)

            // データ保存。Data型にシリアライズする
            do {
                let data: Data = try NSKeyedArchiver.archivedData(withRootObject: todoList, requiringSecureCoding: true)
                // UserDefaultsに保存
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "todoList")
                userDefaults.synchronize()
            } catch {
                // エラー処理なし
            }
        }
    }
}

// 独自クラスをシリアライズする際には、NSOBjectを継承し
// NSSecureCodingプロトコルに準拠する必要がある
class MyTodo: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        true
    }

    // TODOのタイトル
    var todoTitle: String?
    // TODOを完了したかどうかを表すフラグ
    var todoDone: Bool = false
    // コンストラクタ
    override init() {

    }

    // NSCodingプロトコルに宣言されているデシリアライズ処理
    required init?(coder aDcoder: NSCoder) {
        todoTitle = aDcoder.decodeObject(forKey: "todoTTitle") as? String
        todoDone =  aDcoder.decodeBool(forKey: "todoDone")
    }
    // NSCodingプロトコルに宣言されているシリアライズ処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(todoTitle, forKey: "todoTitle")
        aCoder.encode(todoDone, forKey: "todoDone")
    }
}
