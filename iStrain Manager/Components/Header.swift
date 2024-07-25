//
//  Header.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 25/7/2024.
//

import SwiftUI

struct Header: View {
    var body: some View {
   
        HStack {
            Spacer()
            Label("Options", systemImage: "gearshape.fill").labelStyle(.iconOnly)
                .padding(.trailing)
                .font(.system(size:30))
        }
        Spacer()
        
    }
    
}

#Preview {
    Header()
}
