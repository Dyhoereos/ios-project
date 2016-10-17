//
//  MapTests.swift
//  ios-project
//
//  Created by Dennis Chau on 2016-10-17.
//  Copyright © 2016 Manjot. All rights reserved.
//

import XCTest
import MapKit

@testable import ios_project

class MapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMap() {
        //create a rectangle 10.1 x 20.1
        
        let topCorner = MKMapPoint(x: 0, y: 0)
        let botCorner = MKMapPoint(x: 10.1, y:20.1)
        let tileSize = 1
        let map = Map(topCorner: topCorner, botCorner: botCorner, tileSize: tileSize)
        
        //test values initialized by init
        XCTAssertEqual(true, topCorner.x ==  map.getTopCorner().x)
        XCTAssertEqual(true, topCorner.y ==  map.getTopCorner().y)
        XCTAssertEqual(true, botCorner.x ==  map.getBotCorner().x)
        XCTAssertEqual(true, botCorner.y ==  map.getBotCorner().y)
        
        // tile size
        XCTAssertEqual(true, tileSize ==  Tile.getTileSize())
        // map size based on tile dimensions
        XCTAssertEqual(true, 10*20 ==  map.getMapSize().height * map.getMapSize().width)
        // create map rectangle
        XCTAssertEqual(true, 10*20 ==  map.getMapActual().size.height * map.getMapActual().size.width)
        // number of tiles that make up the up
        XCTAssertEqual(true, 10*20 ==  map.getTileSet().count)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
