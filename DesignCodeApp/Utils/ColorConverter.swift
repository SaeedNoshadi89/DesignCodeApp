//
//  ColorConverter.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/20/22.
//

import SwiftUI

func updateColorToString(color: Color) -> String{
    let uiColor = UIColor(color)
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return "\(red),\(green),\(blue),\(alpha)"
}


func updateStringToColor(color: String) -> Color{
    var bgColor: Color? = Color(.blue)
    let rgbArray = color.components(separatedBy: ",")
    if let red = Double (rgbArray[0]),
       let green = Double (rgbArray[1]),
       let blue = Double(rgbArray[2]),
       let alpha = Double (rgbArray[3]){
        bgColor = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
    return bgColor ?? Color(.blue)
}
