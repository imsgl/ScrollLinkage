//
//  BaseTableView.swift
//  Scroll.Linkage
//
//  Created by 孙国立 on 2020/6/8.
//  Copyright © 2020 Elliot. All rights reserved.
//

import UIKit

class BaseTableView: UITableView , UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
    

}
