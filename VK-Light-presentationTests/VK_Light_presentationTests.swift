//
//  VK_Light_presentationTests.swift
//  VK-Light-presentationTests
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import XCTest
@testable import VK_Light_presentation

class VK_Light_presentationTests: XCTestCase {

    var allFriendCell: AllFriendCell!
    var allFriendDataTableView: AllFriendDataTableView!
    
    override func setUp() {
        super.setUp()
        allFriendCell = AllFriendCell()
        allFriendDataTableView = AllFriendDataTableView()
    }

    override func tearDown() {
        allFriendCell = nil
        allFriendDataTableView = nil
        super.tearDown()
    }

    func testAllFriendCellConfigure() {
        let allFriendCoreDataTest = allFriendDataTableView.allFriend?.last
        guard let noOptional = allFriendCoreDataTest else {return}
        allFriendCell.configure(with: noOptional)
        XCTAssertNil(allFriendCoreDataTest == nil, "пришёл нил")
    }
    
//    func testAllFriendCellConfigure() {
//        let allFriendCoreDataTest: AllFriendCoreData? = nil
//        guard let noOptional = allFriendCoreDataTest else {return}
//        allFriendCell.configure(with: noOptional)
//        XCTAssert(allFriendCoreDataTest == nil, "пришёл нил")
//    }
    
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
