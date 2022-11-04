//
//  ViewController.swift
//  Calculator
//
//  Created by Suresh M on 04/11/22.
//

import UIKit

final class ViewController: UIViewController {

  @IBOutlet private weak var keyInputLabel: UILabel!
  @IBOutlet private weak var collectionViewHightConstraint: NSLayoutConstraint!

  @IBOutlet weak var clearButton: UIButton!
  private let viewModel = ViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    clearButton.isHidden = true
    viewModel.createDataSource()
    collectionViewHightConstraint.constant = UIScreen.main.bounds.width
  }

  @IBAction func clearAction(_ sender: Any) {
    keyInputLabel.text = ""
    clearButton.isHidden = true
  }
  
  @IBAction func backspaceAction(_ sender: Any) {
    if var text = keyInputLabel.text, !text.isEmpty {
      text.removeLast()
      keyInputLabel.text = text
      clearButton.isHidden = text.isEmpty
    }
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? KeyCollectionViewCell
    cell?.setupCell(data: viewModel.dataSource[indexPath.row], index: indexPath.row)
    cell?.actionDelegate = self
    return cell!
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width / 4.0, height: collectionView.bounds.width / 4.0)
  }
}

extension ViewController: ActionDelegate {
  func performCalculatorAction(index: Int) {
    let actionItem = viewModel.dataSource[index]
    if actionItem.actionType == .typing {
      if var text = keyInputLabel.text {
        text += actionItem.title
        keyInputLabel.text = text
        clearButton.isHidden = false
      }
    } else {
      keyInputLabel.text = viewModel.performCalculation(text: keyInputLabel.text ?? "")
    }
  }
}

protocol ActionDelegate: AnyObject {
  func performCalculatorAction(index: Int)
}
