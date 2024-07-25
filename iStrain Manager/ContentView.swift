//
//  ContentView.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 24/7/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
