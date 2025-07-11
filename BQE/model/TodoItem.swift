//
//  TodoItem.swift
//  BQE
//
//  Created by Khalid on 11/07/25.
//

struct TodoItem: Identifiable, Hashable {
    let id: Int
    var title: String
    var description: String
    var isDone: Bool = false
}
