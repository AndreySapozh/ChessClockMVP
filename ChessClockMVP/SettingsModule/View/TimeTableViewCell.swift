//
//  TextTableViewCell.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 04.12.2022.
//

import UIKit


class TimeTableViewCell: UITableViewCell {

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
    
    func set(object: TimeChess) {
        self.timeTitleLabel.text = object.timeChess
    }
    
    func configureTitleLabel()  {
        timeTitleLabel.numberOfLines = 0
        timeTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setTimeTitleLabelConstraints() {
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        timeTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        timeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
