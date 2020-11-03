//
//  Matrix4x4.swift
//  Matrix4x4
//
//  Created by Krasnov Andrey on 01.11.2020.
//

import Foundation


class Matrix: Equatable {
    var data: [[Double]]
    let rows: Int
    let columns: Int
    
    
    subscript(row: Int, column: Int) -> Double {
        get {
            return data[row][column]
        }
        set(newValue) {
            data[row][column] = newValue
        }
    }
    
    subscript(row: Int) -> [Double] {
        get {
            return data[row]
        }
        set(newValue) {
            data[row] = newValue
        }
    }
    
    public static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.columns == rhs.rows, "Count column left matrix must be equals count row right matrix")
        let newMatrix = Matrix(rows: lhs.rows, columns: rhs.columns)
        for i in 0..<lhs.rows {
           for j in 0..<rhs.columns {
             for k in 0..<lhs.columns {
                newMatrix[i][j] += lhs[i][k] * rhs[k][j]
             }
           }
         }
         return newMatrix
    }
    public static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        assert(lhs.columns * lhs.rows == rhs.rows * lhs.columns, "Count columns and rows left matrix must be equals count rows and columns right matrix")
        var isEquals = true
        checkEquals: for i in 0..<lhs.rows {
           for j in 0..<rhs.columns {
            if lhs[i][j].precised(10) != rhs[i][j].precised(10) {
                    isEquals = false
                    break checkEquals
                }
            }
         }
        return isEquals
    }
    
    init(_ matrix: [[Double]]) {
        self.rows = matrix.count
        self.columns = matrix[0].count
        self.data = matrix
    }
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.data = Array(repeating: Array(repeating: 0.0, count: columns), count: rows)
    }
    
    init(x: Double,y: Double,z: Double) {
        self.rows = 3
        self.columns = 1
        self.data = [[x],[y],[z]]
    }
    
    init(x: [Double],y: [Double],z: [Double]) {
        self.rows = 3
        self.columns = max(x.count, y.count, z.count)
        self.data = [x,y,z]
    }
    
    func transfer() -> Matrix {
        guard columns > 1 else {
            var transferMatris: [[Double]] = self.data
            transferMatris.append([1.0])
            return Matrix(transferMatris)
        }
        
        let transferMatris = Matrix(rows: self.rows+1, columns: self.columns+1)
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                transferMatris[i][j] = data[i][j]
           }
        }
        transferMatris[rows][columns] = 1
        return transferMatris
    }
    
    public static func matrixRotateX(angle: Double) -> Matrix{
        return Matrix([[1.0,         0.0,          0.0, 0.0],
                [0.0,  cos(angle),  -sin(angle), 0.0],
                [0.0,  sin(angle),   cos(angle), 0.0],
                [0.0,         0.0,          0.0, 1.0]])
    }
    
    public static func matrixRotateY(angle: Double) -> Matrix {
        return Matrix([[cos(angle),  0.0,   sin(angle), 0.0],
                       [0.0,         1.0,            0, 0.0],
                       [-sin(angle), 0.0,   cos(angle), 0.0],
                       [0.0,         0.0,          0.0, 1.0]])
    }
    
    public static func matrixRotateZ(angle: Double) -> Matrix{
        return Matrix([[cos(angle), -sin(angle),    0.0, 0.0],
                       [sin(angle),  cos(angle),    0.0, 0.0],
                       [       0.0,         0.0,    1.0, 0.0],
                       [       0.0,         0.0,    0.0, 1.0]])
    }

    public static func matrixScale(kx: Double, ky: Double, kz: Double) -> Matrix {
        return Matrix([[kx,  0,  0, 0],
                       [ 0, ky,  0, 0],
                       [ 0,  0, kz, 0],
                       [ 0,  0,  0, 1]])
    }
}

extension Double {
    func precised(_ value: Int = 1) -> Double {
        let offset = pow(10, Double(value))
        return (self * offset).rounded() / offset
      }
}
