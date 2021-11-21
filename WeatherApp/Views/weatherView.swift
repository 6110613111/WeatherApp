//
//  ContentView.swift
//  WeatherApp
//
//  Created by Natthaporn Wimonanupong on 16/11/2564 BE.
//

import SwiftUI
// key api : f3e89f182d7a5bf1c365e70e896850b9
struct weatherView: View {
    
    //@ObservedObject var model = WeatherModel()
    @Binding var showWeather: Bool
    var weather: WeatherResponse
    var country: String
    let colorpp = Color.init(red: 31.0/255.0, green: 165.0/255.0, blue: 255.0/255.0)
    let colornn = Color.init(red: 255.0/255.0, green: 248.0/255.0, blue: 242.0/255.0)
    var body: some View {
        // Display the weather
        
        VStack{
            VStack{
                
                HStack{
                    Text("Weather in \(country)")
                        .font(.system(size: 25,weight: .medium))
                        .fontWeight(.medium)
                    
                }.padding(.top,40)
                
                
                VStack{
                    // weather for today each hour
                    HStack{
                        Image(systemName:"\(formaticon(icon: weather.current.weather[0].description))")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(self.colorpp)
                        VStack(alignment: .leading){
                            Text("Today")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                            Text("\(formattedDate(weather.current.dt))")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                    }
                    Text("\(tempToString(temp: weather.current.temp)) °C")
                        .font(.system(size: 50))
                        .fontWeight(.light)
                        .foregroundColor(self.colorpp)
                    Text("\(weather.current.weather[0].description)")
                        .font(.system(size: 18))
                        .fontWeight(.light)
                }
                .frame(width: 390, height: 200)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: .init(.sRGB, white: 0, opacity: 0.25), radius: 4, x: 0, y: 4)
            }
            .padding()
            
            VStack{
                
                HStack(spacing:40){
                    VStack(alignment: .leading){
                        Text("SUNRISE ")
                            .font(.system(size: 13))
                        Text("\(formatSun(weather.current.sunrise))")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                    }
                    VStack(alignment: .leading){
                        Text("SUNSET ")
                            .font(.system(size: 13))
                        Text("\(formatSun(weather.current.sunset))")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                    }
                    VStack(alignment: .leading){
                        Text("UV INDEX ")
                            .font(.system(size: 13))
                        Text("\(formatuv(uv: weather.current.uvi))")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                        
                    }
                    
                    
                }
                
            }
            
            ScrollView(.horizontal){
                HStack{
                    Spacer()
                    ForEach(weather.hourly){ hour in
                        VStack(spacing: 20){
                            Text("\(formatHour(hour.dt))")
                                .font(.system(size: 22))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            Text("\(tempToString(temp: hour.temp)) °C")
                                .font(.system(size: 25))
                                .fontWeight(.light)
                                .foregroundColor(.white)
                            
                            Image(systemName:"\(formaticon(icon: hour.weather[0].description))")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 110, height: 180)
                        .background(self.colorpp)
                        .cornerRadius(8)
                        .shadow(color: .init(.sRGB, white: 0, opacity: 0.35), radius: 4, x: 0, y: 4)
                    }
                }
            }
            
            
            VStack{
                ForEach(1..<weather.daily.count){ dayIndex in
                    HStack{
                        Text("\(formattedDateAfter(weather.daily[dayIndex].dt))")
                            .frame(width: 90, height: 37, alignment: .leading)
                        Spacer()
                        Image(systemName: formaticon(icon:weather.daily[dayIndex].weather[0].description))
                            .foregroundColor(self.colorpp)
                        
                        Spacer()
                        Text("\(tempToString(temp: weather.daily[dayIndex].temp.day)) °C")
                    }
                    
                }
                
                
            }
            .padding()
        }.background(self.colornn)
        
    }
    
    
    
    // format temperature -> .1f
    func tempToString(temp: Double) -> String{
        return String(format: "%.1f", temp)
    }
    
    // format Time -> yers : date : month
    func formattedDate(_ unix: Double) -> String {
        // Siurce date
        let date  = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        return dateFormatter.string(from: date)
    }
    
    func formatHour(_ unix: Double) -> String {
        // Siurce date
        let date  = Date(timeIntervalSince1970: unix)
        
        // Desired format
        let hourFormatter = DateFormatter()
        hourFormatter.locale = Locale(identifier: "en_US_POSIX")
        hourFormatter.dateFormat = "h a"
        hourFormatter.amSymbol = "AM"
        hourFormatter.pmSymbol = "PM"
        return hourFormatter.string(from: date)
    }
    
    func formatSun(_ unix: Double) -> String {
        // Siurce date
        let date  = Date(timeIntervalSince1970: unix)
        
        // Desired format
        let hourFormatter = DateFormatter()
        hourFormatter.locale = Locale(identifier: "en_US_POSIX")
        hourFormatter.dateFormat = "h:MM a"
        hourFormatter.amSymbol = "AM"
        hourFormatter.pmSymbol = "PM"
        return hourFormatter.string(from: date)
    }
    
    //format day advance
    func formattedDateAfter(_ unix: Double) -> String {
        // Siurce date
        let date  = Date(timeIntervalSince1970: unix)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    //format uv
    func formatuv(uv: Double) -> String {
        if(uv <= 2.9){ return "1"}
        else if(uv >= 3 && uv <= 5.9){ return "2" }
        else if(uv >= 6 && uv <= 7.9){ return "3" }
        else if(uv >= 8 && uv <= 10.9){ return "4" }
        else{ return "5" }
    }
    
    //icon
    func formaticon(icon :String) -> String {
        switch icon{
        case "few clouds" :
            return "cloud.sun.fill"
        case "overcast clouds" :
            return "smoke.fill"
        case "broken clouds" :
            return "smoke.fill"
        case "moderate rain" :
            return "cloud.sun.rain.fill"
        case "scattered clouds" :
            return "cloud.fill"
        case "clear sky" :
            return "sun.max.fill"
        case "mist" :
            return "cloud.fog.fill"
        case "rain" :
            return "cloud.rain.fill"
        case "heavy intensity rain" :
            return "cloud.heavyrain"
        case "light rain" :
            return "cloud.drizzle.fill"
        case "thunderstorm" :
            return "cloud.bolt.fill"
        case "ragged thunderstorm" :
            return "cloud.bolt.fill"
        case "thunderstorm with light rain" :
            return "cloud.bolt.rain"
        case "thunderstorm with rain" :
            return "cloud.bolt.rain.fill"
        case "thunderstorm with heavy rain" :
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
    
    
}


//        if let weather1 = model.weather {
//            // Display the weather
//            Text("Weather in \(country)")
//            Text("\(tempToString(temp: weather.current.temp)) Celsius")
//            Text("Status: \( weather.current.weather[0].description)")
//
//            List(weather.hourly){ hour in
//               Text("Hour: \(secondsToHour(hour.dt)), Temp: \(tempToString(temp: hour.temp)), Status: \( hour.weather[0].description)")
//            }
//        }
//        else{
//            ProgressView()
//        }
