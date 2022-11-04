//
//  ViewModel.swift
//  Calculator
//
//  Created by Suresh M on 04/11/22.
//

import Foundation

final class ViewModel {

  var dataSource: [ActionKey] = []

  func createDataSource() {
    let actionKey9 = ActionKey(title: "9", colorType: 1, actionType: .typing)
    let actionKey8 = ActionKey(title: "8", colorType: 1, actionType: .typing)
    let actionKey7 = ActionKey(title: "7", colorType: 1, actionType: .typing)
    let actionKeyDivide = ActionKey(title: "/", colorType: 2, actionType: .typing)
    let actionKey6 = ActionKey(title: "6", colorType: 1, actionType: .typing)
    let actionKey5 = ActionKey(title: "5", colorType: 1, actionType: .typing)
    let actionKey4 = ActionKey(title: "4", colorType: 1, actionType: .typing)
    let actionKeyMultiply = ActionKey(title: "*", colorType: 2, actionType: .typing)
    let actionKey3 = ActionKey(title: "3", colorType: 1, actionType: .typing)
    let actionKey2 = ActionKey(title: "2", colorType: 1, actionType: .typing)
    let actionKey1 = ActionKey(title: "1", colorType: 1, actionType: .typing)
    let actionKeyAdd = ActionKey(title: "+", colorType: 2, actionType: .typing)
    let actionKey0 = ActionKey(title: "0", colorType: 1, actionType: .typing)
    let actionKeyDot = ActionKey(title: ".", colorType: 1, actionType: .typing)
    let actionKeyEqual = ActionKey(title: "=", colorType: 1, actionType: .action)
    let actionkeyMinus = ActionKey(title: "-", colorType: 2, actionType: .typing)

    dataSource.append(actionKey9)
    dataSource.append(actionKey8)
    dataSource.append(actionKey7)
    dataSource.append(actionKeyDivide)
    dataSource.append(actionKey6)
    dataSource.append(actionKey5)
    dataSource.append(actionKey4)
    dataSource.append(actionKeyMultiply)
    dataSource.append(actionKey3)
    dataSource.append(actionKey2)
    dataSource.append(actionKey1)
    dataSource.append(actionKeyAdd)
    dataSource.append(actionKey0)
    dataSource.append(actionKeyDot)
    dataSource.append(actionKeyEqual)
    dataSource.append(actionkeyMinus)
  }

  func performCalculation(text: String) -> String {
    var inputText = text
    if text.last == "*" || text.last == "/" || text.last == "+" || text.last == "-" || text.last == "." {
      inputText.removeLast()
    }
    var numbers: [String] = []
    var operators: [Character] = []
    var startIndex: String.Index = inputText.startIndex

    for item in inputText.enumerated() {
      if item.element == "-" && item.offset == 0 {
        continue
      }
      if item.element == "*" || item.element == "/" || item.element == "+" || item.element == "-" {
        operators.append(item.element)
        if numbers.isEmpty {
          let endIndex = inputText.index(startIndex, offsetBy: item.offset - 1)
          let subString = inputText[startIndex...endIndex]
          numbers.append(String(subString))
          startIndex = inputText.index(after: endIndex)
        } else {
          let endIndex = inputText.index(inputText.startIndex, offsetBy: item.offset - 1)
          let index1 = inputText.index(after: startIndex)
          let subString = inputText[index1...endIndex]
          numbers.append(String(subString))
          startIndex = inputText.index(after: endIndex)
        }

      }
      if item.offset == inputText.count - 1 {
        let endIndex = inputText.endIndex
        let index1 = inputText.index(after: startIndex)
        let subString = inputText[index1..<endIndex]
        numbers.append(String(subString))
      }
    }
    var numbersCopy = numbers
    for item in operators.enumerated() {
      var value = ""
      switch item.element {
      case "+":
        let lhs = convertNumeric(text: numbersCopy[0])
        let rhs = convertNumeric(text: numbersCopy[1])
        if let lhsValue = lhs as? Int, let rhsValue = rhs as? Int {
          let additionValue = addtionOperation(lhs: lhsValue,
                                               rhs: rhsValue)
          value = String(additionValue)
        } else if let lhsValue = lhs as? Double, let rhsValue = rhs as? Double {
          let additionValue = addtionOperation(lhs: lhsValue,
                                               rhs: rhsValue)
          value = String(additionValue)
        } else {
          let addtionValue = addtionOperation(lhs: Double(numbersCopy[0]) ?? 0, rhs: Double(numbersCopy[1]) ?? 0)
          value = String(addtionValue)
        }
      case "-":
        let lhs = convertNumeric(text: numbersCopy[0])
        let rhs = convertNumeric(text: numbersCopy[1])
        if let lhsValue = lhs as? Int, let rhsValue = rhs as? Int {
          let sunstractionValue = substractionOperation(lhs: lhsValue,
                                               rhs: rhsValue)
          value = String(sunstractionValue)
        } else if let lhsValue = lhs as? Double, let rhsValue = rhs as? Double {
          let sunstractionValue = substractionOperation(lhs: lhsValue,
                                               rhs: rhsValue)
          value = String(sunstractionValue)
        } else {
          let sunstractionValue = substractionOperation(lhs: Double(numbersCopy[0]) ?? 0, rhs: Double(numbersCopy[1]) ?? 0)
          value = String(sunstractionValue)
        }
      case "*":
        let lhs = convertNumeric(text: numbersCopy[0])
        let rhs = convertNumeric(text: numbersCopy[1])
        if let lhsValue = lhs as? Int, let rhsValue = rhs as? Int {
          let multiplicationValue = multiplicationOperation(lhs: lhsValue,
                                                    rhs: rhsValue)
          value = String(multiplicationValue)
        } else if let lhsValue = lhs as? Double, let rhsValue = rhs as? Double {
          let multiplicationValue = multiplicationOperation(lhs: lhsValue,
                                                    rhs: rhsValue)
          value = String(multiplicationValue)
        } else {
          let multiplicationValue = multiplicationOperation(lhs: Double(numbersCopy[0]) ?? 0, rhs: Double(numbersCopy[1]) ?? 0)
          value = String(multiplicationValue)
        }
      case "/":
        let lhs = convertNumeric(text: numbersCopy[0])
        let rhs = convertNumeric(text: numbersCopy[1])
        let divisionValue = divisionOperation(lhs: lhs, rhs: rhs)
        if let value1 = divisionValue as? Int {
          value = String(value1)
        } else if let value2 = divisionValue as? Double {
          value = String(value2)
        }

      default:
        break
      }
      numbersCopy.removeFirst()
      numbersCopy.removeFirst()
      numbersCopy.insert(value, at: 0)
    }
    return numbersCopy.first ?? ""
  }

  func convertNumeric(text: String) -> Any {
    if text.contains(".") {
      let doubleValue = NumberFormatter().number(from: text)?.doubleValue
      return (text as NSString).doubleValue
    } else {
      return Int(text) ?? 0
    }
  }

  func addtionOperation<T: Numeric>(lhs: T, rhs: T) -> T {
    return lhs + rhs
  }

  func substractionOperation<T: Numeric>(lhs: T, rhs: T) -> T {
    return lhs - rhs
  }

  func multiplicationOperation<T: Numeric>(lhs: T, rhs: T) -> T {
    return lhs * rhs
  }

  func divisionOperation(lhs: Any, rhs: Any) -> Any {
    if let valueLhs = lhs as? Int, let valueRhs = rhs as? Int {
      return valueLhs / valueRhs
    } else if let valueLhs = lhs as? Double, let valueRhs = rhs as? Double {
      return valueLhs / valueRhs
    } else if let valueLhs = lhs as? Int, let valueRhs = rhs as? Double {
      return Double(valueLhs) / valueRhs
    } else if let valueLhs = lhs as? Double, let valueRhs = rhs as? Int {
      return valueLhs / Double(valueRhs)
    }
    return 0
  }
}

struct ActionKey {
  let title: String
  let colorType: Int
  let actionType: ActionType
}

enum ActionType {
  case typing
  case action
}
