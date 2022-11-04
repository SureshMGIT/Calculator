//
//  KeyCollectionViewCell.swift
//  Calculator
//
//  Created by Suresh M on 04/11/22.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var titleButton: UIButton!

  var index: Int?
  weak var actionDelegate: ActionDelegate?

  func setupCell(data: ActionKey, index: Int) {
    titleButton.setTitle(data.title, for: .normal)
    titleButton.layer.cornerRadius = ((UIScreen.main.bounds.width / 4.0) - 20.0) / 2
    titleButton.layer.masksToBounds = true
    titleButton.backgroundColor = data.colorType == 1 ? .darkGray : .orange
    self.index = index
  }

  @IBAction func tapAction(_ sender: Any) {
    if let index = index {
      actionDelegate?.performCalculatorAction(index: index)
    }
  }
  
}
