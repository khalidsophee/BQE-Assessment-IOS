//
//  ContentView.swift
//  BQE
//
//  Created by Khalid on 11/07/25.
//

import SwiftUI


struct ContentView: View {
    @State private var todoList: [TodoItem] = []
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var idCounter: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Title", text: $title)
                    .accessibilityIdentifier("titleField") // i use this to access the specific view in testing 
                    .textFieldStyle(.roundedBorder)
            

                TextField("Description (Optional)", text: $description)
                    .accessibilityIdentifier("descField")
                    .textFieldStyle(.roundedBorder)
               

                Button("Add To-Do") {
                    guard !title.isEmpty else { return }
                    let newItem = TodoItem(id: idCounter, title: title, description: description)
                    todoList.append(newItem)
                    idCounter += 1
                    title = ""
                    description = ""
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .accessibilityIdentifier("addTodoButton")

                Divider()

                List {
                    ForEach(todoList, id: \.id) { item in
                        TodoItemRow(item: item, onToggle: {
                            toggleCompletion(for: item)
                        }, onDelete: {
                            deleteItem(item)
                        })
                    }
                }
            }
            .padding()
            .navigationTitle("To-Do List")
        }
    }

    func toggleCompletion(for item: TodoItem) {
        if let index = todoList.firstIndex(of: item) {
            todoList[index].isDone.toggle()
        }
    }

    func deleteItem(_ item: TodoItem) {
        todoList.removeAll { $0.id == item.id }
    }
}

struct TodoItemRow: View {
    var item: TodoItem
    var onToggle: () -> Void
    var onDelete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .strikethrough(item.isDone)
                    .fontWeight(.medium)
                    .accessibilityIdentifier("todoTitle_\(item.id)")

                if !item.description.isEmpty {
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("todoDesc_\(item.id)")
                }
            }

            Spacer()

            Toggle("", isOn: Binding(
                get: { item.isDone },
                set: { _ in onToggle() }
            ))
            .labelsHidden()
            .accessibilityIdentifier("toggle_\(item.id)")

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .accessibilityIdentifier("delete_\(item.id)")
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
