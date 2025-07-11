//
//  BQEUITests.swift
//  BQE
//
//  Created by Khalid on 11/07/25.
//


import XCTest

final class BQEUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddTodoItem_displaysInList() {
        let app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
        
        let titleField = app.textFields["titleField"]
        print(app.debugDescription)
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))
        titleField.tap()
        titleField.typeText("BQE Item 1")

        let descField = app.textFields["descField"]
        descField.tap()
        descField.typeText("Dummy Item")

        app.buttons["addTodoButton"].tap()

        let title = app.staticTexts["todoTitle_0"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))

        let desc = app.staticTexts["todoDesc_0"]
        XCTAssertTrue(desc.waitForExistence(timeout: 2))
    }

    func testMarkTodoItemAsComplete() {
        let app = XCUIApplication()
        app.launch()

        let titleField = app.textFields["titleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))
        titleField.tap()
        titleField.typeText("BQE Item")

        app.buttons["addTodoButton"].tap()

        let toggle = app.switches["toggle_0"]
        XCTAssertTrue(toggle.waitForExistence(timeout: 3))
        toggle.tap()

        let title = app.staticTexts["todoTitle_0"]
        XCTAssertTrue(title.exists) // You can further test strikethrough via screenshots if needed
    }

    func testDeleteTodoItem_removesFromList() {
        let app = XCUIApplication()
        app.launch()

        let titleField = app.textFields["titleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 3))
        titleField.tap()
        titleField.typeText("BQE Item")

        app.buttons["addTodoButton"].tap()

        let todo = app.staticTexts["todoTitle_0"]
        XCTAssertTrue(todo.waitForExistence(timeout: 3))

        let deleteButton = app.buttons["delete_0"]
        XCTAssertTrue(deleteButton.exists)
        deleteButton.tap()

        XCTAssertFalse(todo.waitForExistence(timeout: 2))
    }

    func testAddMultipleItemsAndValidateList() {
        let app = XCUIApplication()
        app.launch()

        let tasks = ["BQE A", "BQE B", "BQE C"]

        for (index, task) in tasks.enumerated() {
            let titleField = app.textFields["titleField"]
            XCTAssertTrue(titleField.waitForExistence(timeout: 2))
            titleField.tap()
            
            // Debug: Print value before clearing
            print("Before clearing: \(titleField.value ?? "nil")")
            if let stringValue = titleField.value as? String, !stringValue.isEmpty {
                let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
                titleField.typeText(deleteString)
            }
            
            // Debug: Print value after clearing
            print("After clearing: \(titleField.value ?? "nil")")
            titleField.typeText(task)
            titleField.typeText("\n") // Dismiss keyboard if needed
            app.buttons["addTodoButton"].tap()
            
            // Wait for the UI to update
            let title = app.staticTexts["todoTitle_\(index)"]
            let exists = title.waitForExistence(timeout: 5)
            print("Looking for todoTitle_\(index): exists = \(exists)")
            
            // Print all staticTexts for debugging
            let allStaticTexts = app.staticTexts.allElementsBoundByIndex
            for label in allStaticTexts {
                print("Identifier: \(label.identifier), Label: \(label.label)")
            }
            XCTAssertTrue(exists, "\(task) not found in list")
        }
    }


}
