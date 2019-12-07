//
//  ViewController.swift
//  MyTodoList
//
//  Created by harapeko on 2019/12/06.
//  Copyright © 2019 dev.harapeko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // テーブルの行数を返却する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO配列の長さを返却
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // storyboadで設定したtodoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        

        // 行番号に合ったTODOのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        // 行番号に合ったTODOのタイトルをセット
        cell.textLabel?.text = todoTitle
        return cell
    }
    
    // TODOを格納する配列
    var todoList = [String]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        let alertController = UIAlertController(title: "TODO追加",
                                                message: "TODOを入力してください",
                                                preferredStyle: UIAlertController.Style.alert)
        
        // テキストエリア追加
        alertController.addTextField(configurationHandler: nil)

        // OKボタン追加
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            if let textField = alertController.textFields?.first {
                // TODO配列に入力値を挿入する
                self.todoList.insert(textField.text!, at: 0)
                // 行が追加されたことをTable Viewに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)],
                                          with: UITableView.RowAnimation.right)
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
}

