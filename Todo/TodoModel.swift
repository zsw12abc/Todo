//
//  TodoModel.swift
//  Todo
//
//  Created by Shaowei Zhang on 15/7/4.
//  Copyright © 2015年 Shaowei Zhang. All rights reserved.
//

import UIKit

//  建立 model 的类 只会复制指针
class TodoModel: NSObject {
    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    //初始化
    init (id: String, image: String, title:String, date: NSDate){
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}

// struct 不需要初始化 会放在 stack 里面 会复制所有值 所以不会修改属性 重置的话会消耗更多资源
// 在这里不用的原因是因为我们需要修改 item 如果用 struct 的话, 只会修改副本 不会修改本体 导致修改无效化
/*struct TodeModel2{
    var id: String
    var image: String
    var title: String
    var date: NSDate
}
*/