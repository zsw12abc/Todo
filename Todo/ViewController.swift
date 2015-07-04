//
//  ViewController.swift
//  Todo
//
//  Created by Shaowei Zhang on 15/7/4.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit

//初始化临时的数据库 全局变量 整个 APP 都可以访问 重启就会清空
var todos: [TodoModel] = []


func dateFromString(dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}

//引入协议 UITableViewDataSource 同时重写它的函数
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //加入初始化的 Todo list 的内容
        todos = [TodoModel(id: "1", image: "child-selected", title: "1. 去游乐场", date:  dateFromString("2014-11-02")!),
            TodoModel(id: "2", image: "shopping-cart-selected", title: "2. 购物", date:  dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "phone-selected", title: "3. 打电话", date:  dateFromString("2014-10-30")!),
            TodoModel(id: "4", image: "travel-selected", title: "4. Travel to Europe", date:  dateFromString("2014-10-31")!)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // UITableViewDataSource 的必要函数重写
    //返回 table 多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //动态加在多少行
        return todos.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    //table 显示效果
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //只执行当前屏幕能显示的 cell 当滚动的时候会释放掉已经消失的 cell 然后加载新的 cell "todoCell" 是 cell 的 id 需要复制到 storyboard 的 cell 中
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell!
        
        //取出第几行的 TodoModelb
        let todo = todos[indexPath.row] as TodoModel
        //通过去 storyboard 中给各个控件附加独有的 Tag 来进行绑定(2.0 中强转型 as 要加!)
        let image = cell.viewWithTag(101) as! UIImageView
        let title = cell.viewWithTag(102) as! UILabel
        let date = cell.viewWithTag(103) as! UILabel
        
        //根据 todos 里面每行 cell 的图片名称来载入图片
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        //读取用户手机里设置的所在地点
        let locale = NSLocale.currentLocale()
        //根据用户所在地点修改日期格式
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        date.text = dateFormatter.stringFromDate(todo.date)
        
        
        
        return cell
        //如果运行还没有内容 说明 tabelView 没有绑定到 UITableViewDataSource, 去 storyboard 把 tableView 绑定到 ViewController 上 选择 dataSource
    }

}

