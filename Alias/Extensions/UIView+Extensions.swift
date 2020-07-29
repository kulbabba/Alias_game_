//
//  UIView+Extensions.swift
//  Alias
//
//  Created by Oleg Ivaniv on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import Foundation
import SnapKit

extension UIView {

    /// This method adds subview that fills all the space of the superview
    func addFullyExtended(_ view: UIView) {
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
