//
//  CommentViewController.swift
//  Instagram
//
//  Created by Takeru on 2021/07/25.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
            // HUDで投稿処理中の表示を開始
            SVProgressHUD.show()
            
        if let text = textField.text {
            // FireStoreに投稿データを保存する
            var updateValue: FieldValue
            // コメント追加する更新データを作成
            updateValue = FieldValue.arrayUnion([text])
            // commentsに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comments": updateValue])
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
           UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // ログイン画面を表示する
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
        self.present(homeViewController!, animated: true, completion: nil)
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
