//
//  Project-CoreDataHelpers.swift
//  UltimatePortfolioApp
//
//  Created by Tina on 14/11/2020.
//

import Foundation

extension Project {
    var projectTitle: String {
        title ?? "New Project"
    }
    
    var projectDetail: String {
        detail ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    
    var projectItems: [Item] {
        let itemsArray = items?.allObjects as? [Item] ?? []
        
        return itemsArray.sorted { first, second in
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var completionAmount: Double {
        guard projectItems.isEmpty == false else { return 0 }
        
        let completedItems = projectItems.filter(\.completed)
        
        return Double(completedItems.count) / Double(projectItems.count)
    }
    
    static var example: Project {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.closed = true
        project.creationDate = Date()
        
        return project
    }
}
