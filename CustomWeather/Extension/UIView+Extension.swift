//
//  UIView+Extension.swift
//  CustomWeather
//
//  Created by Артем Свиридов on 05.04.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }

    func makeLable(sizeFont: CGFloat) -> UILabel {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: sizeFont)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }
}
