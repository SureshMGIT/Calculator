//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Suresh M on 04/11/22.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {

  var viewModel: ViewModel?

  override func setUpWithError() throws {
    viewModel = ViewModel()
  }

  override func tearDownWithError() throws {
    viewModel = nil
  }

  func testCreateDataSource() {
    viewModel?.createDataSource()
    XCTAssertEqual(viewModel?.dataSource.count, 16)
  }

  func testPerformCalculation() {
    let text = viewModel?.performCalculation(text: "1+2+3")
    XCTAssertEqual(text, "6")
  }

  func testConvertNumeric() {
    let value = viewModel?.convertNumeric(text: "100")
    XCTAssertEqual(value as? Int, 100)
  }

  func testAddtionOperation() {
    let value = viewModel?.addtionOperation(lhs: 10, rhs: 10)
    XCTAssertEqual(value, 20)
  }

  func testSubstractionOperation() {
    let value = viewModel?.substractionOperation(lhs: 20, rhs: 10)
    XCTAssertEqual(value, 10)
  }

  func testMultiplicationOperation() {
    let value = viewModel?.multiplicationOperation(lhs: 10, rhs: 10)
    XCTAssertEqual(value, 100)
  }

  func testDivisionOperation() {
    let value = viewModel?.divisionOperation(lhs: 100, rhs: 10)
    XCTAssertEqual(value as? Int, 10)
  }

}
