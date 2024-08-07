//
//  ContentView.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 24/7/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("didLaunchBefore") var didLaunchBefore: Bool = false;

    var body: some View {
        VStack {


            NavigationStack {
                        
                Header()
                
                WelcomeBanner(hasOpenedBefore: didLaunchBefore)

                Spacer()
                
                Group {
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Label("Analytics", systemImage: "chart.bar.xaxis.ascending")
                    } .simultaneousGesture(TapGesture().onEnded(pressedButton))
                        .buttonStyle(.bordered)
                    
                    NavigationLink {
                        TimerPage()
                    } label: {
                        Text("Start Session")
                    }
                    .buttonStyle(.borderedProminent)
                    .simultaneousGesture(TapGesture().onEnded(pressedButton))
                }
                
                Spacer()
            }
            
        }
    }
    
    private func pressedButton() {
        didLaunchBefore = true;
    }

}

#Preview {
    ContentView()
}
