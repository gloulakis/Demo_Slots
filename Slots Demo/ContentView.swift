//
//  ContentView.swift
//  Slots Demo
//
//  Created by Georgios Loulakis on 24.02.22.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple","star","cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var betAmount = 5
    @State private var backgrounds = Array(repeating:Color.white,count: 9)
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 14/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 255/255, green: 255/255, blue: 255/255))
                .rotationEffect(Angle(degrees: 45))
                .cornerRadius(100)
            VStack{
                Spacer()
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.white)
                    Text("Slots")
                        .bold()
                        .padding(10)
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 0.9, x: 1, y: 2)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                    
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.red)
                }.scaleEffect(2)
                
                Spacer()
                
                Text("Credits: \(credits)")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.all,10)
                    .background(Color.red.opacity(0.7))
                    .cornerRadius(20)
                
                Spacer()
                VStack{
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[0]],background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]],background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]],background: $backgrounds[2])
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[3]],background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]],background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]],background: $backgrounds[5])
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        CardView(symbol: $symbols[numbers[6]],background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]],background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]],background: $backgrounds[8])
                        Spacer()
                    }
                }
                Spacer()
                HStack (spacing:20){
                    VStack{
                        Button {
                            self.procesResults()
                        } label: {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading,.trailing],30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) Credits")
                            .bold()

                            .padding(.top,10)
                            .font(.footnote)
                    }
                    VStack{
                        Button {
                            self.procesResults(true)
                        } label: {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all,10)
                                .padding([.leading,.trailing],30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) Credits")
                            .bold()
                            .padding(.top,10)
                            .font(.footnote)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .shadow(radius: 50)
            }
        }
    }
    func procesResults(_ isMax:Bool = false){
        self.backgrounds = self.backgrounds.map({ _ in
            Color.white
        })
        
        if isMax {
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count - 1 )
            })
        } else {
            self.numbers[0]=Int.random(in: 0...symbols.count - 1)
            self.numbers[1]=Int.random(in: 0...symbols.count - 1)
            self.numbers[2]=Int.random(in: 0...symbols.count - 1)
        }
        
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false){
        var matches = 0
        
        if !isMax{
            if isMatch(3, 4, 5){
                matches += 1
            }
        }
        else {
            if isMatch(0, 1, 2) {matches += 1}
            if isMatch(3, 4, 5) {matches += 1}
            if isMatch(6, 7, 8) {matches += 1}
            if isMatch(0, 4, 8) {matches += 1}
            if isMatch(2, 4, 6) {matches += 1}
            
            if matches > 0 {
                self.credits += matches * betAmount * 2
            } else if !isMax{
                self.credits -= betAmount
            } else {
                self.credits -= betAmount * 5
            }
        }
    }
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int )->
    Bool{
        if self.numbers[index1] == self.numbers[index2] &&
            self.numbers[index2] == self.numbers[index3]{
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
        }
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
