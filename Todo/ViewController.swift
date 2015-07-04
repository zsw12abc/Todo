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
//继承协议 UITableViewDelegate 来删除 Cell
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //加入初始化的 Todo list 的内容
        todos = [TodoModel(id: "1", image: "child-selected", title: "去游乐场", date:  dateFromString("2014-11-02")!),
            TodoModel(id: "2", image: "shopping-cart-selected", title: "购物", date:  dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "phone-selected", title: "打电话", date:  dateFromString("2014-10-30")!),
            TodoModel(id: "4", image: "travel-selected", title: "Travel to Europe", date:  dateFromString("2014-10-31")!)]
        
        //激活导航栏左边的 edit 按钮
        navigationItem.leftBarButtonItem = editButtonItem()
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
    
    // UITableViewDeleage中的函数 用来插入和删除数据 同时隐藏 optional
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    /*optional*/ func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)
            //删除数据后要重新刷新 table
            //self.tableView.reloadData()
            //加入删除的动画效果
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //激活 Edit Mode
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
        //需要去激活导航栏左边的 edit 按钮
    }
    
    
    // 移动 Moving/reordering 只有在用户点击的时候才能移动
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    //从起始行移动到目标行
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        //先删除要移动的那一项
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        //插入到目标行
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    
    //加入点击确定后返回此页面 同时要去 storyboard 的 Detail界面下绑定确定按钮到 exit
    @IBAction func close(segue: UIStoryboardSegue){
        print("closed")
        tableView.reloadData()
    }
    
    //通过判断哪个 segue way 跳转到 DetailViewController 来确定是否要传输数据
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //判断是哪个 segue way 根据 id 来判断
        if segue.identifier == "EditTodo" {
            let vc = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }

}

