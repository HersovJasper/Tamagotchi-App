//
//  Tamagotchi.swift
//  Tamagotchi App
//
//  Created by Jasper Hersov on 22/01/2021.
//

import Foundation

class Tamagotchi: ObservableObject {
    
    @Published var age: Int
    @Published var hunger: Int{
        didSet {
            if hunger < 0{
                hunger = 0
            }
        }
    }
    @Published var happiness: Int
    @Published var howIll: Int
    @Published var isTamagotchiDead: Bool = false
    @Published var weight: Int {
        didSet {
            if weight < 0{
                weight = 0
            } else if weight > 10{
                weight = 10
            }
        }
    }

    
    init(){
        age = 1
        hunger = 0
        happiness = 0
        weight = 0
        howIll = 0
        isTamagotchiDead = false
    }
    
    func displayStats() -> String{
        return """
            TAMAGOTCHI STATISTICS
            Age: \(age)
            Weight: \(weight)
            Hunger: \(hunger)
            Happiness: \(happiness)
            Illness Level: \(howIll)
            """
    }
    
    func feedMeal() {
        hunger -= 2
        weight += 1
    }
    
    func feedSnack() {
        hunger -= 1
        happiness += 5
    }

    func giveMedicine(){
        howIll -= 5
        hunger -= 5
    }
    
    func bathroom(){
        let random = Int.random(in: 1...3)
        if random == 1{
            hunger -= 10
            howIll = 0
        } else{
            hunger += 10
        }
    }
}
