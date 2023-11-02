//
//  Smoking+CoreDataProperties.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 26/10/2023.
//
//

import Foundation
import CoreData

extension Smoking {
    @NSManaged public var cigarettesInPack: Int32
    @NSManaged public var cigarettesPerDay: Int32
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Smoking> {
        return NSFetchRequest<Smoking>(entityName: "Smoking")
    }
}

extension Smoking: Identifiable {

}
