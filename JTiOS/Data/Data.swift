//
//  Data.swift
//  JTiOS
//
//  Created by JT on 2017/12/20.
//  Copyright © 2017年 JT. All rights reserved.
//

import CoreData

class Data {
    
    static let shareInstance = Data()
    private init() {}
    
    private let persistentContainerName = "Data"
    private let coreDataSqliteName = "CoreData.sqlite"
    
    private let data_LoginName = "Data_Login"
    private let data_Login_Username = "username"
    private let data_Login_Password = "password"
    
    func saveContext() {
        if #available(iOS 10.0, *) {
            saveContext10()
        } else {
            // Fallback on earlier versions
        }
    }
    
    lazy var manageObjectContext: NSManagedObjectContext = {
        if #available(iOS 10.0, *) {
            return persistentContainer.viewContext
        } else {
            return managedObjectContext
        }
    }()
    
    @available(iOS 10.0 , *)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        })
        return container
    }()
    
    @available(iOS 10.0, *)
    private func saveContext10 () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: persistentContainerName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = FileManage.shareInstance.documentFile.appendingPathComponent(coreDataSqliteName)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            abort()
        }
        return coordinator
    }()
    
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }() 
}

extension Data {
    
    func SaveData_Login(username: String?, password: String?){
        let dataLogin = NSEntityDescription.insertNewObject(forEntityName: data_LoginName, into: manageObjectContext) as? Data_Login
        guard let d = dataLogin else { return }
        d.username = username
        d.password = password
        try? manageObjectContext.save()
    }

    func ClearData_Login(){
        let fetchRequest = NSFetchRequest<Data_Login>(entityName: data_LoginName)
        let sr = try? manageObjectContext.fetch(fetchRequest)
        guard let srs = sr, srs.count > 0 else {
            return
        }
        for x in srs {
            manageObjectContext.delete(x as NSManagedObject)
        }
        try? manageObjectContext.save()
    }
    
    func GetData_Login() -> Data_Login? {
        let fetchRequest = NSFetchRequest<Data_Login>(entityName: data_LoginName)
        let searchResults = try? manageObjectContext.fetch(fetchRequest)
        if let sr = searchResults, sr.count > 0 {
            let dataLogin = sr[0] as Data_Login
            return dataLogin
        }
        return nil
    }

}
