//
//  WelcomeBanner.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 25/7/2024.
//

import SwiftUI

struct WelcomeBanner: View {
    let hasOpenedBefore: Bool;
    
    var body: some View {
        let message = hasOpenedBefore ? "Welcome Back!" : "Welcome!"
        
        Text(message)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.system(size: 60))
            .multilineTextAlignment(.center)
       
    }
}

#Preview {
    WelcomeBanner(hasOpenedBefore: false)
}
