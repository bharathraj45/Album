//
//  AlbumTests.swift
//  AlbumTests
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import XCTest
@testable import Album

class AlbumTests: XCTestCase {
    
    let albums = [Album(userId: 1, id: 1, title: "first"),
                  Album(userId: 1, id: 2, title: "second"),
                  Album(userId: 1, id: 3, title: "third"),
                  Album(userId: 1, id: 4, title: "fourth"),
                  Album(userId: 1, id: 5, title: "fifth")]
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearchTextDataPass() {
        let albumId = 1
        let updatedAlbum = albums.filter({ ($0.id == albumId) })
        XCTAssertTrue(updatedAlbum.count > 0, "User album is present")
    }
    
    func testSearchTextDataFail() {
        let albumId = 6
        let updatedAlbums = albums.filter({ ($0.id == albumId) })
        XCTAssertTrue(updatedAlbums.count > 0, "User album is not present")
    }
}
