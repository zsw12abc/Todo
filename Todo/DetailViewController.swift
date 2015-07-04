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
    
    //用来存储编辑项目的数据 有可能为空 所以是 optional
    var todo: TodoModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItem.delegate = self
        
        //如果 todo 是空的 说明是新增 否则是修改 需要读取todo 的数据同时写给项目
        if todo == nil {
            childButton.selected = true
            navigationController?.title = "新增Todo"
        }
        else {
            navigationController?.title = "修改Todo"
            if todo?.image == "child-selected" {
                childButton.selected = true
            }
            else if todo?.image == "shopping-cart-selected" {
                shoppingCartButton.selected = true
            }
            else if todo?.image == "phone-selected" {
                phoneButton.selected = true
            }
            else if todo?.image == "travel-selected" {
                travelButton.selected = true
            }
            todoItem.text = todo?.title
            todoDate.setDate(todo!.date, animated: false)
        }//还需要修改  okTapped 按钮的功能 让它判定是添加还是修改

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
        
        //判定确定是修改还是添加项目
        if todo == nil {
            //swift2.0 中把 NSUUID.UUID().UUIDString 改为了 NSUUID().UUIDString
            let uuid = NSUUID().UUIDString
            todo = TodoModel(id: uuid, image: image, title: todoItem.text!, date: todoDate.date)
            todos.append(todo!)
        }else{
            todo?.image = image
            todo?.title = todoItem.text!
            todo?.date = todoDate.date
        }
        
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
