//
//  ClockFace.swift
//  iStrain Manager
//
//  Created by Ahmad Adam on 28/7/2024.
//

import SwiftUI

struct ClockFace: View {
    @Binding var seconds: Int;
    
    var body: some View {
        let minute = seconds / 60;
        let second = seconds % 60;
        
        let min1 = String(minute/10);
        let min2 = String(minute%10);
        
        let sec1 = String(second/10);
        let sec2 = String(second%10);
        
        HStack {
            Spacer()
            Text("Minutes")
            Spacer()
            Text("Seconds")
            Spacer()
        }
        
        HStack {
            Group {
                Text(min1)
                Text(min2)
            }.frame(width: 60).multilineTextAlignment(.center)
            
            Text(":").frame(width: 30)
                
            Group {
                Text(sec1)
                Text(sec2)
            }.frame(width: 60).multilineTextAlignment(.center)
        }
        .font(.system(size:105))
    }
}

struct ClockFacePreview: PreviewProvider {
    static var previews: some View {
        let previewTime:Int = (12*60)-1
        ClockFace(seconds: .constant(previewTime))
    }
}
