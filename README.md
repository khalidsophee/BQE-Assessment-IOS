# 🧾 To-Do List iOS App

**Created by Khalid Aziz**

---

## 📱 Description

A lightweight and user-friendly To-Do list iOS application built using **SwiftUI** and **Swift 6**. The app allows users to:

- Add tasks with optional descriptions  
- Mark tasks as completed  
- Delete tasks from the list  

---

## UI Framework

- **SwiftUI (Swift 6)**
- Clean and minimal interface
- Native Apple Human Interface Guidelines compliance

---

## Features

- Add new tasks
- Check/uncheck tasks as complete/incomplete
- Delete tasks
- Strikethrough styling for completed tasks

---

## 🧪 Testing
- **UI Tests:** XCUITest (SwiftUI interaction validation)

### 📋 Test Coverage Includes:

- Adding tasks
- Marking tasks complete/incomplete
- Deleting tasks

> ✅ Total Tests: `~4`  
> - UI Tests: `4`  

---

## 🧪 How to Run Tests

1. Open the project in **Xcode 16+**
2. Select `Product` > `Test` from the top menu  
   **OR** press **⌘ + U**  
3. To run a specific test:
   - Open the **Test Navigator (⌘ + 6)**
   - Click run next to the desired test or test class

---

##Sample Test Tags (AccessibilityIdentifiers)

All major UI elements have identifiers for testing:

- `titleField` – Text field for entering title
- `descField` – Text field for entering description
- `addTodoButton` – Button to add a task
- `toggle_{id}` – Checkbox for task toggle
- `delete_{id}` – Delete button for task

---


