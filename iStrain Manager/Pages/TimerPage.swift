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
        }
    }
}

let WORK_LENGTH: Int = (60 * 20);
let REST_LENGTH: Int = (20);
let ACTIVE_LENGTH: Int = (60 * 5);

let ROUNDS_BETWEEN_ACTIVE: Int = (3);

struct TimerPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @State var isPaused = false;
    @State var sessionState = TimerState.Work
    
    @State var cycle = 1;
    @State var roundsTillActive = ROUNDS_BETWEEN_ACTIVE;
    
    @State var timerOver = false;
    @State var timeRemaining: Int = WORK_LENGTH;
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let pauseMessage = isPaused ? "Resume" : "Pause"
        
        VStack {
            
            // TODO: Add audio/notif. Then do settings mngmnt. Then analytics. Should add back button in intermediary state
            SessionLabels(cycle: $cycle, tillActive: $roundsTillActive)
            
            Spacer()
                
            ClockFace(seconds: $timeRemaining)
            
            Group {
                Text("\(sessionState)")
            }.font(.title)
            
            Spacer()
            Spacer()
            
            ZStack{
                VStack{
                    Group {
                        Button(action: pauseAction, label: {
                            Text(pauseMessage).animation(.none)
                        })
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        Button(action: stopAction, label: {
                            Text("Stop")
                                .padding(.horizontal, 13.0)
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .disabled(isPaused ? false: true)
                        .controlSize(.large)
                    }.opacity(timerOver ? 0:1)
                }
                
                VStack {
                    Group {
                        Button(action: nextSession, label: {
                            Text("Next Session")
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .controlSize(.large)
                        
                        Button(action: getActive, label: {
                            Text("Get Active")
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .controlSize(.large)
                        .disabled(roundsTillActive > 1)
                    }
                }.opacity(timerOver ? 1:0)
            }.frame(height: 150)
            
            Spacer()
        }
        .background(StateColours.getColor(state: sessionState))
        .navigationBarBackButtonHidden(true)
        .onReceive(timer){ _ in
            guard isActive && !isPaused else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1;
            } else if timeRemaining == 0 {
                timerOver = true;
            }
        }
        .onChange(of: scenePhase) { _ in
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
        sessionState = .Work;
        timerOver = false;
        roundsTillActive = ROUNDS_BETWEEN_ACTIVE;
        cycle = 1;
    }
    
    private func nextSession() {
        switch sessionState {
            case .Work:
                timeRemaining = REST_LENGTH
                sessionState = .Rest
            case .Rest:
                timeRemaining = WORK_LENGTH
                sessionState = .Work
                roundsTillActive -= 1;
                cycle += 1
            case .Active:   
                timeRemaining = WORK_LENGTH
                sessionState = .Work
                cycle += 1
        }
        timerOver = false
    }
    
    private func getActive() {
        roundsTillActive = ROUNDS_BETWEEN_ACTIVE;
        timeRemaining = ACTIVE_LENGTH
        sessionState = .Active;
        timerOver = false
    }
    
}

#Preview {
    TimerPage()
}
