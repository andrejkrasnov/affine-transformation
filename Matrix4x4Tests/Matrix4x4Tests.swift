//
//  Matrix4x4Tests.swift
//  Matrix4x4Tests
//
//  Created by Krasnov Andrey on 01.11.2020.
//

import XCTest
@testable import Matrix4x4

class Matrix4x4Tests: XCTestCase {

    func testScale()  {
        let sourceMatrix = Matrix(x: [3.0,3.0,3.0],
                                  y: [1.0,-6.0,9.0],
                                  z: [1.0,-8.0,2.0])
        let scaleMatrix = Matrix.matrixScale(kx: 3.0, ky: -2.0, kz: 1.5)
        let expectedMatrix = Matrix([[9.0,9.0,9.0,0.0],
                                     [-2.0,12.0,-18.0,0.0],
                                     [1.5,-12.0,3.0,0.0],
                                     [0.0,0.0,0.0,1.0]])
        let transferSourceMatrix = sourceMatrix.transfer()
       
        XCTAssertEqual(scaleMatrix * transferSourceMatrix, expectedMatrix)
    }
    
    func testRotateZ() {
        let sourceMatrix = Matrix(x: 1,
                                  y: 0,
                                  z: 0)
        let rotateMatrix = Matrix.matrixRotateZ(angle: 0.927295218)
        let expectedMatrix = Matrix([[0.6],[0.8],[0.0],[1.0]])
        let transferSourceMatrix = sourceMatrix.transfer()
     
        XCTAssertEqual(rotateMatrix * transferSourceMatrix, expectedMatrix)
    }
    
    func testRotateX() {
        let sourceMatrix = Matrix(x: 1,
                                  y: 0,
                                  z: 0)
        let rotateMatrix = Matrix.matrixRotateX(angle: 0.927295218)
        let expectedMatrix = Matrix([[1.0],[0.0],[0.0],[1.0]])
        let transferSourceMatrix = sourceMatrix.transfer()

        XCTAssertEqual(rotateMatrix * transferSourceMatrix, expectedMatrix)
    }
    
    func testRotateY() {
        let sourceMatrix = Matrix(x: 1,
                                  y: 0,
                                  z: 0)
        let rotateMatrix = Matrix.matrixRotateY(angle: 0.927295218)
        let expectedMatrix = Matrix([[0.6],[0.0],[-0.8],[1.0]])
        let transferSourceMatrix = sourceMatrix.transfer()

        XCTAssertEqual(rotateMatrix * transferSourceMatrix, expectedMatrix)
    }
}
