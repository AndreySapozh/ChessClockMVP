//
//  TextTableViewCell.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 04.12.2022.
//

import UIKit


final class TimeTableViewCell: UITableViewCell {
    
    var timeTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(timeTitleLabel)
        configureTitleLabel()
        setTimeTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(object: TimeRealm) {
        self.timeTitleLabel.text = object.name
    }
    
    
    func configureTitleLabel()  {
        timeTitleLabel.numberOfLines = 0
        timeTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setTimeTitleLabelConstraints() {
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            timeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
