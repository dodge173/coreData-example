//
//  CoreDataManger.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//
import CoreData
import UIKit

class CoreDataManger {
    static let shared = CoreDataManger()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetch<T: NSManagedObject>(returnType: T.Type , completion: @escaping ([T]) -> Void) {
        do {
            guard let result = try context.fetch(returnType.fetchRequest()) as? [T] else {
                return
            }
            completion(result)
        } catch {
            //
        }
    }
    
    func delete<T: NSManagedObject>(returnType: T.Type, delete: T) {
        context.delete(delete.self)
        do {
            try context.save()
        } catch {
            //
        }
    }
}
