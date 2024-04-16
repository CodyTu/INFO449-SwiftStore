//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation
import XCTest

protocol SKU {
    var name: String {get}
    
    func price() -> Int
}

class Item: SKU {
    var name: String
    var priceEach: Int
    
    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }
    
    func price() -> Int {
        return priceEach
    }
}

class Receipt {
    var scannedItems: [SKU] = []
    
    func add(item: SKU) {
        scannedItems.append(item)
    }
    
    func items() -> [SKU] {
        return scannedItems
    }
    
    func total() -> Int {
        var total = 0
        for i in self.scannedItems {
            total += i.price()
        }
        return total
    }
    
    func output() -> String {
        var outString = "Receipt:\n"
        for i in self.scannedItems {
            outString += "\(i.name): $\(Double(i.price())/100)\n"
        }
        outString += "------------------\n"
        outString += "TOTAL: $\(Double(self.total())/100)"
        return outString
    }
}

class Register {
    var currentReceipt: Receipt = Receipt()
    
    func scan(_ item: SKU) {
        currentReceipt.add(item: item)
    }
    
    func subtotal() -> Int {
        return currentReceipt.total()
    }
    
    func total() -> Receipt{
        var reciept = currentReceipt
        currentReceipt = Receipt()
        return reciept
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

final class ItemTest: XCTestCase {
    var register = Register()
    
    func testItem() {
        register.scan(Item(name: "Apple", priceEach: 500))
        XCTAssertEqual(500, register.subtotal())
    }
}

