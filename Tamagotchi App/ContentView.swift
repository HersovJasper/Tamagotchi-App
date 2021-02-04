//
//  ContentView.swift
//  Tamagotchi App
//
//  Created by Jasper Hersov on 22/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var tamagotchi = Tamagotchi()
    @State private var remainingTime = 30
    @State var alerts: String{
        didSet {
            if remainingTime > 0{
                if tamagotchi.howIll > 5{
                    alerts = "Tamagotchi is dying"
                } else if tamagotchi.hunger > 10{
                    self.alerts = "Tamagotchi is hungry"
                }
            }else{
                alerts = "Time up. Age reached: \(tamagotchi.age)"
            }
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var timerUp: Bool {
        return remainingTime > 0 ? false : true
    }
    
    var body: some View {
        VStack{
            Text("\(remainingTime)")
                .foregroundColor(.red)
                .bold()
                .onReceive(timer) { _ in
                    if remainingTime > 0{
                        remainingTime -= 1
                        tamagotchi.age += 1
                        if remainingTime%2 == 0{
                            tamagotchi.hunger += 1
                        }
                    }
                }
        
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text("You have 30 seconds to keep your Tamagotchi alive as long as possible. It gets hungrier as time goes on. Keep feeding it and use medicine if it is ill. If it is ill for more than 5 seconds it will die. Going to the bathroom may make it better or worse!!!").font(.system(size: 12, weight: .light, design: .serif))
                    Text(alerts).font(.headline).foregroundColor(.red)
                    Text("\(tamagotchi.displayStats())")
                }
            }
            Spacer()
            VStack{
                HStack(alignment: .top, spacing: 20){
                    Button("Meal", action: {
                        tamagotchi.feedMeal()
                    }).disabled(timerUp)
                    Button("Snack", action: {
                        tamagotchi.feedSnack()
                    }).disabled(timerUp)
                    Button("Medicine", action: {
                        tamagotchi.giveMedicine()
                    }).disabled(timerUp)
                    Button("Bathroom", action: {
                        tamagotchi.bathroom()
                    }).disabled(timerUp)

                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(alerts: "Game has started")
    }
}
