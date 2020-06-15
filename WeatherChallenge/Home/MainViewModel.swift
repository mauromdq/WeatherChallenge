//
//  MainViewModel.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import Foundation
import Bond
import CoreData

class MainViewModel: ViewModel {
    
    typealias DataSource = MainDataSource
    typealias Router = MainRouter

    private let router: MainRouter
    private let context: Context

    let cityNames = Observable<[String]>(["Buenos Aires", "Londres", "Los Angeles","Mar del Plata", "Madrid", "Moscow", "Miami", "New York", "Paris", "Pekin", "Roma", "Sidney", "Tokio", "Ushuaia"])
    let selectedCity = Observable<String?>(nil)
    private(set) var canContinue = Observable(false)
    
    required init(dataSource: DataSource, router: Router) {
        self.router = router
        context = dataSource.context
        getFromCoreData()
    }
    
    func toCurrent() {
        saveInCoreData()
        router.routeToCurrent(dataSource: CurrentDataSource(context: context, selectedCity: selectedCity))
    }
    
    func toDaily() {
        saveInCoreData()
        router.routeToDaily(dataSource: DailyDataSource(context: context, selectedCity: selectedCity))
    }

    func onUpdate(withStateAtIndex index: Int) {
        selectedCity.value = cityNames.value[index]
        canContinue.value = true        
    }    
}

extension MainViewModel {
    func saveInCoreData() {
        guard let city = selectedCity.value else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SelectedCity", in: context)
        let newSel = NSManagedObject(entity: entity!, insertInto: context)
        newSel.setValue(city, forKey: "cityName")
        do {
           try context.save()
          } catch {
           print("Failed saving")
        }
    }
    
    func getFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SelectedCity")
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                selectedCity.value = (data.value(forKey: "cityName") as! String)
                canContinue.value = true
          }
            
        } catch {
            print("Failed")
        }
    }
}
