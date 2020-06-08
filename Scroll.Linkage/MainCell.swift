//
//  MainCell.swift
//  Scroll.Linkage
//
//  Created by 孙国立 on 2020/6/5.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.childerScrollView)
    }
    
    lazy var childerScrollView : ChilderScrollView = {
        let childerScrollView = ChilderScrollView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - SECTION_HEADER_HEIGHT))
        return childerScrollView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ChilderScrollView : UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: self.frame.size.height)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.addSubview(self.leftChilder)
        self.addSubview(self.rightChilder)
        
    }
    
    
    
    lazy var leftChilder : ChilderTableView = {
        let leftChilder = ChilderTableView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), type: 1)
        return leftChilder
    }()
    
    lazy var rightChilder : ChilderTableView = {
        let rightChilder = ChilderTableView.init(frame: CGRect(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height), type: 2)
        return rightChilder
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





class ChilderTableView: UITableView {
    
    var type : Int = 0
    var canScroll = false
    init(frame: CGRect , type : Int) {
        super.init(frame: frame, style: .plain)
        self.type = type
        self.dataSource = self
        self.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(changeValue), name: NSNotification.Name(rawValue: "ChilderNotice"), object: nil)
    }
    
    @objc func changeValue(){
        self.canScroll = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ChilderTableView : UITableViewDelegate, UITableViewDataSource , UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "childerCell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "childerCell")
        }
        
        cell?.textLabel?.text = String.init(format: "类型是:%d - 下标是:%d", self.type , indexPath.row)
        
        return cell!
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //开始的时候子视图是无法滚动的  canScroll属性为false
        if !self.canScroll{
            scrollView.contentOffset = CGPoint.zero
        }
        //如果子视图的滚动高度小于等于0证明子视图滚动到了头部
        if scrollView.contentOffset.y <= 0 {
            self.canScroll = false
            //给主视图的tableView发送改变是否可以滚动的状态。让主视图的tbaleView可以滚动
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mainNotice"), object: nil)
        }
    }
    
    
}
