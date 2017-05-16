//
//  ViewController.swift
//  SwiftWunderlist1
//
//  Created by 宮本一彦 on 2016/11/21.
//  Copyright © 2016年 宮本一彦. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var backImageView: UIImageView!
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var textField: UITextField!
    
    // 配列
    var titleArray = [String]()
    
    var label:UILabel = UILabel()
    
    // 選択されたCellの番号が入れる
    var count:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        textField.delegate = self
        
        backView.layer.cornerRadius = 10.0
        
        table.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // titleArrayをアプリ内から出す
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
        }
        
        if(UserDefaults.standard.object(forKey: "image") != nil) {
        
            let numberString = UserDefaults.standard.string(forKey: "image")
            
            backImageView.image = UIImage(named: numberString! + ".jpg")
        }
        
        //tableViewをreloadしてデリゲートメッソドを再度呼び出す
        table.reloadData()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 配列の中に文字を入れる
        titleArray.append(textField.text!)
        
        // 配列をアプリ内に保存する
        UserDefaults.standard.set(titleArray, forKey: "array")
        
        // 残った文字を空にする
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            textField.text = ""
            table.reloadData()
        }
        
        // キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 画面遷移をする
        count = Int(indexPath.row)
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    // Segue準備
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
    
        if (segue.identifier == "next") {
            let nextVC: NextViewController = segue.destination as! NextViewController
            
            // 番号を入れる
            nextVC.selectedNumber = count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        
            //titleArrayの選択された番号の配列に入っている文字を削除
            titleArray.remove(at: indexPath.row)
            
            // もう一度配列をアプリ内へ保存する
            UserDefaults.standard.set(titleArray, forKey: "array")
            // tableのデリゲートメッソドを呼ぶ
            table.reloadData()
            
        } else if editingStyle == .insert {
            //
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

