//
//  DetailViewController.swift
//  Todo
//
//  Created by Shaowei Zhang on 15/7/4.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit

// 继承协议 UITextFieldDelegate 来引入去掉焦点(隐藏键盘)
class DetailViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var childButton: UIButton!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var shoppingCartButton: UIButton!
    
    @IBOutlet weak var travelButton: UIButton!
    
    @IBOutlet weak var todoItem: UITextField!
    
    @IBOutlet weak var todoDate: UIDatePicker!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItem.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
        childButton.selected = false
        phoneButton.selected = false
        shoppingCartButton.selected = false
        travelButton.selected = false
    }
    //选中按钮改变按钮的状态 去 storyboard 中修改 selected 后的图标
    @IBAction func childTapped(sender: AnyObject) {
        resetButtons()
        childButton.selected = true
    }

    @IBAction func phoneTapped(sender: AnyObject) {
        resetButtons()
        phoneButton.selected = true
    }
    
    @IBAction func shoppingCartTapped(sender: AnyObject) {
        resetButtons()
        shoppingCartButton.selected = true
    }
    
    @IBAction func travelTapped(sender: AnyObject) {
        resetButtons()
        travelButton.selected = true
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        var image = ""
        if childButton.selected {
            image = "child-selected"
        }
        else if phoneButton.selected {
            image = "phone-selected"
        }
        else if shoppingCartButton.selected {
            image = "shopping-cart-selected"
        }
        else if travelButton.selected {
            image = "travel-selected"
        }
        
        //swift2.0 中把 NSUUID.UUID().UUIDString 改为了 NSUUID().UUIDString
        let uuid = NSUUID().UUIDString
        let todo = TodoModel(id: uuid, image: image, title: todoItem.text!, date: todoDate.date)
        todos.append(todo)
        
    }
    
    //点击键盘 enter 后会去掉焦点(自动隐藏键盘)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //点击其他地方也去掉焦点
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        todoItem.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
