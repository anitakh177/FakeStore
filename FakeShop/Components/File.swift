//
//  File.swift
//  FakeShop
//
//  Created by anita on 07.07.2022.
//

import UIKit

private let productCountLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textAlignment = .right
    label.textColor = .red
    label.text = "1"
    return label
}()

private let iconView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .black
    imageView.image = UIImage(systemName: "cart")
    return imageView
}()

 let buttonView: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    view.addSubview(iconView)
    view.addSubview(productCountLabel)
    return view
}()

