//
//  contentView.swift
//  WeatherApp
//
//  Created by Natthaporn Wimonanupong on 17/11/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = WeatherModel()
    @State var showWeather = false
    let colorblue = Color.init(red: 3.0/255.0, green: 3.0/255.0, blue: 97.0/255.0)
    let colorpp = Color.init(red: 58.0/255.0, green: 123.0/255.0, blue: 201.0/255.0)
    let colornn = Color.init(red: 255.0/255.0, green: 248.0/255.0, blue: 242.0/255.0)
    var countryName:[String] = ["Thailand", "Brunei Darussalam", "Cambodia", "Laos" ,"Malaysia", "Myanmar", "Philippines", "Singapore", "Vietnam", "Indonesia"]
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [self.colorpp, self.colorpp]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("COUNTRY")
                    .font(.system(size: 32,weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                
                ScrollView(){
                    VStack{
                        ForEach(0..<countryName.count){ countryIndex in
                            Button(action: {
                                model.set(country: countryName[countryIndex])
                                showWeather.toggle()
                            }){
                                Text("\(countryName[countryIndex])")
                                    .frame(width: 280, height: 50)
                                    .font(.system(size: 20,weight: .bold, design:.default))
                                    .foregroundColor(.black)
                                    .background(self.colornn)
                                    .cornerRadius(10)
                                    .shadow(color: .init(.sRGB, white: 0, opacity: 0.25), radius: 4, x: 0, y: 4)
                            }.padding()
                        }
                        
                        
                    }
                    .sheet(isPresented: $showWeather){
                        weatherView(showWeather: $showWeather, weather: model.weather!, country: model.country)
                    }
                    
                }
            }
            .frame(width: .infinity, height:700)
        }
    }
}

//struct contentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(country: country)
//    }
//}
