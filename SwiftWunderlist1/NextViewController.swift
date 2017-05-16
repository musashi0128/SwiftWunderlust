//
//  NextViewController.swift
//  SwiftWunderlist1
//
//  Created by 宮本一彦 on 2016/11/22.
//  Copyright © 2016年 宮本一彦. All rights reserved.
//

import UIKit
import MessageUI

class NextViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    
    // 配列
    var titleArray:Array = [String]()
    
    
    // セルが選択された番号が入ってくる変数
    var selectedNumber:Int = 0
    
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
    @IBAction func openMail(_ sender: Any) {
        var mailViewController = MFMailComposeViewController()

        
        // メールを開く
        mailViewController.mailComposeDelegate = self
        
        // 本文
        mailViewController.setMessageBody(textView.text, isHTML: false)
        // 件名
        mailViewController.setSubject("件名")
        // To(誰に送るか)
        let mailAddres = ["k.miyamoto.0128@gmail.com"]
        mailViewController.setToRecipients(mailAddres)
        
        present(mailViewController, animated: true, completion: nil)
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true,completion:nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // titleArrayをアプリから取り出す
        if(UserDefaults.standard.object(forKey: "array") != nil) {
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            textView.text = titleArray[selectedNumber]
        }
        
        // 前の画面で選択された番号の文字をtitleArrayから取り出す
        
        // textViewへ反映する
        
    }
    
    // テキストビューを閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(textView.isFirstResponder) {
            textView.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
