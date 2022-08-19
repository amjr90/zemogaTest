//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//

import UIKit
import Domain

class PostTableViewCell: UITableViewCell {

    public static let cellIdentifier = "PostTableViewCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView(){
        addSubview(label)
        addSubview(icon)
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20),
            icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            label.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func configure(with post: Post){
        setupView()
        setupConstrains()
        label.text = post.title
        showOrHideFavoriteIcon(value: post.favorite ?? false)
    }
    
    func showOrHideFavoriteIcon(value: Bool){
        icon.isHidden = !value
    }
}
