//
//  TaskViewModel.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 07/02/2021.
//

import Foundation
import Combine

let testDataTasks = [
    Task(title:"Book 1", completed:true),
    Task(title:"Book 2", completed:true),
    Task(title:"Book 3", completed:false),
]

struct Task{
    var title: String
    var completed: Bool
}

class TaskViewModel: ObservableObject, Identifiable {
    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    init(task:Task){
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
    }
    
}
