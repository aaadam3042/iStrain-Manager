//
//  TimerPage.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 25/7/2024.
//

import SwiftUI

struct TimerPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPaused = false;
    
    var body: some View {
        let pauseMessage = isPaused ? "Resume" : "Pause"
        
        VStack {
            Header()
            
            
            
            VStack {
                Text("Cycle {X}")
                Text("Round {X}")
            }.font(.title).fontWeight(.bold)
            
            Spacer()
            
            Group {
                HStack {
                    Spacer()
                    Text("Minutes")
                    Spacer()
                    Text("Seconds")
                    Spacer()
                }
                
                Text("00:00")
                    .font(.system(size:105))
            }
            
            Group {
                Text("Work")
            }.font(.title)
            
            Spacer()
            Spacer()
            Spacer()
            
            Group {
                
                Button(action: pauseAction, label: {
                    Text(pauseMessage).animation(.none)
                })
                .buttonStyle(.borderedProminent)
                .controlSize(.extraLarge)
              
                Button(action: stopAction, label: {
                    Text("Stop")
                        .padding(.horizontal, 13.0)
                })
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .disabled(isPaused ? false: true)
                .controlSize(.extraLarge)
                
            }
            Spacer()
        }
        .background(.green)
        .navigationBarBackButtonHidden(true)
    }
    
    private func pauseAction() {
        isPaused.toggle()
    }
    
    private func stopAction() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

#Preview {
    TimerPage()
}
