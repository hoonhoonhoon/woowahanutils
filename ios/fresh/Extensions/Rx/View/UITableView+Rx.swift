//
//  UITableView+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 1. 4..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {

	func scrollToTop(animated: Bool = false) -> Binder<Void> {
		return Binder.init(self.base, binding: { (tableView, _) in
			self.base.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: animated)
		})
	}

}
