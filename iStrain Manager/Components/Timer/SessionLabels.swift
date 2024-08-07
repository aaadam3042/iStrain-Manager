//
//  SessionLabels.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 28/7/2024.
//

import SwiftUI

struct SessionLabels: View {
    @Binding var cycle: Int;
    @Binding var tillActive: Int;
    
    var body: some View {
        
        VStack {
            Text("Cycle \(cycle)")
            Text("Active in \(cyclesLeft(int: tillActive)) cycles")
        }.font(.title).fontWeight(.bold)
    }
    
    private func cyclesLeft(int: Int) -> Int {
        var result = int - 1
        return result > 0 ? result : 0
    }
}

