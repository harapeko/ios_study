import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// セッションの取り出し
let session = URLSession.shared

// URLオブジェクトを生成
if let url = URL(string: "https://www.yahoo.co.jp") {
    // リクエストオブジェクトを生成
    let request = URLRequest(url: url)
    
    // 処理タスクを生成
    let task = session.dataTask(with: request) {
        (data:Data?, response:URLResponse?, error:Error?) in

        // データ取得後に呼ばれる処理はここに記載する
        guard let data = data else {
            print("データなし")
            return
        }
        
        // レスポンスデータをを文字列に変換して出力
        // (Data型の変数をString型に変換)
        if let value = String(data: data, encoding: String.Encoding.utf8) {
            print(value)
        }
    }
    
    // 処理開始
    task.resume()
}
