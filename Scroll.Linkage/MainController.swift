//
//  MainController.swift
//  Scroll.Linkage
//
//  Created by 孙国立 on 2020/6/5.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let HEADER_HEIGHT : CGFloat = 300//tableHeaderView的高度
let SECTION_HEADER_HEIGHT : CGFloat = 100//section的高度



class MainController: UIViewController {

    var canScroll = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(valueChange), name: NSNotification.Name(rawValue: "mainNotice"), object: nil)
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @objc func valueChange(){
        self.canScroll = true
    }
    
    //MARK: tableView
    lazy var tableView : BaseTableView = {
        let tableView = BaseTableView.init(frame: self.view.bounds)
        tableView.backgroundColor = .red
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = self.headerView
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = SECTION_HEADER_HEIGHT
        return tableView
    }()
    
    lazy var headerView : UIView = {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: HEADER_HEIGHT))
        headerView.backgroundColor = .red
        return headerView
    }()
    
    lazy var sectionHeaderView : SectionHeaderView = {
        let sectionHeaderView = SectionHeaderView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SECTION_HEADER_HEIGHT))
        return sectionHeaderView
    }()
    
    

}

//MARK: tableViewDataSource
extension MainController : UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate , UIGestureRecognizerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")
        if cell == nil {
            cell = MainCell.init(style: .default, reuseIdentifier: "MainCell")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT - SECTION_HEADER_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sectionHeaderView
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //如果高度大于等于tableHeaderView的高度的时候
        if scrollView.contentOffset.y >=  HEADER_HEIGHT{
            //设置ContentOffsetY的高度为tableHeaderView的高度
            scrollView.contentOffset = CGPoint(x: 0, y: HEADER_HEIGHT)
            if self.canScroll {
                self.canScroll = false//设置是否可以滚动的参数为false
                //发送通知给子tableView。设置子tableView的可滚动属性为true
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChilderNotice"), object: nil)
            }
        }else{
            if !self.canScroll {
                scrollView.contentOffset = CGPoint(x: 0, y: HEADER_HEIGHT)
            }
        }
    }
    
    
    
    
}




class SectionHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .orange
        self.setItemBtn()
    }
    
    
    func setItemBtn(){
        
        let itemNameArray = ["标题1","标题2"]
        
        for (index, value) in itemNameArray.enumerated() {
            let btn = UIButton.init(frame: CGRect(x: CGFloat(index) * self.frame.size.width / 2.0 , y: 0, width: self.frame.size.width / 2.0, height: self.frame.size.height))
            btn.setTitle(value, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            if index == 0 {
                btn.setTitleColor(.blue, for: .normal)
            }
            self.addSubview(btn)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

