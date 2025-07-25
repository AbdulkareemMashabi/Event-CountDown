//
//  EventRow.swift
//  Event Countdown
//
//  Created by Abdulkareem Mashabi on 25/01/1447 AH.
//

import SwiftUI

struct EventRow: View {
    @Binding var event: Event
    @State private var now = Date.now
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(event.title).foregroundStyle(event.textColor)
            Text(dateDescription(for: event.date, relativeTo: now)).onReceive(timer) {
                date in
                now = date
            }
        }.onReceive(timer) { currentDate in
            now = currentDate
        }
    }
    
    private func dateDescription(for date: Date, relativeTo anotherDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: date, relativeTo: anotherDate)
    }
    
}

#Preview {
    @Previewable @State var event = Event(title: "Do home Work", date: Date(), textColor: .blue)
    EventRow(event: $event)
}
