//
//  TimerPage.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 25/7/2024.
//

import SwiftUI

enum TimerState {
    case Work
    case Rest
    case Active
}

class StateColours {
    static func getColor(state: TimerState) -> Color {
        switch state {
        case .Work:
            return Color.gray;
        case .Rest:
            return Color.green;
        case .Active:
            return Color.yellow;
        case _:
            return Color.pink;
        }
    }
}

let WORK_LENGTH: Int = (60*20);
let REST_LENGTH: Int = (20);
let ACTIVE_LENTH: Int = (0);

struct TimerPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State var isPaused = false;
    @State var sessionState = TimerState.Work
    
    @State var timeRemaining: Int = WORK_LENGTH;
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let pauseMessage = isPaused ? "Resume" : "Pause"
        
        VStack {
            
            VStack {
                Text("Cycle {X}")
                Text("Round {X}")
            }.padding(.top, 20.0).font(.title).fontWeight(.bold)
            
            Spacer()
            
            Group {
                HStack {
                    Spacer()
                    Text("Minutes")
                    Spacer()
                    Text("Seconds")
                    Spacer()
                }
                
            ClockFace(seconds: $timeRemaining)
                
            }
            
            Group {
                Text("\(sessionState)")
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
        .background(StateColours.getColor(state: sessionState))
        .navigationBarBackButtonHidden(true)
        .onReceive(timer){ _ in
            guard isActive && !isPaused else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1;
            } else if timeRemaining == 0 {
                // TODO: Add state logic here - add cycle and round - make env var lengths
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                isActive = true
            } else {
                isActive = false
            }
        }
        .onAppear() {
            UIApplication.shared.isIdleTimerDisabled = true;
        }
        .onDisappear() {
            UIApplication.shared.isIdleTimerDisabled = false;
        }
    }
    
    private func pauseAction() {
        isPaused.toggle();
    }
    
    private func stopAction() {
        presentationMode.wrappedValue.dismiss();
        timeRemaining = WORK_LENGTH;
    }
    
}

#Preview {
    TimerPage()
}
