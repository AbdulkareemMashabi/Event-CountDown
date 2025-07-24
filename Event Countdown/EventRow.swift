//
//  EventRow.swift
//  Event Countdown
//
//  Created by Abdulkareem Mashabi on 25/01/1447 AH.
//

import SwiftUI

struct EventRow: View {
    @Binding var event: Event
    @State private var now = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(event.title).foregroundStyle(event.textColor)
            Text(timeRemainingString())
        }
    }
    
    
    
    private func timeRemainingString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: event.date, relativeTo: now)
    }
}

#Preview {
    @Previewable @State var event = Event(title: "Do home Work", date: Date(), textColor: .blue)
    EventRow(event: $event)
}
