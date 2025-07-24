//
//  EventsView.swift
//  Event Countdown
//
//  Created by Abdulkareem Mashabi on 25/01/1447 AH.
//

import SwiftUI

enum Mode { case add, edit(Event) }

struct EventsView: View {
    @State var events: [Event]
    
    init() {
        self.events = FileHelper.load() ?? []
    }
    
    func onSave (event: Event) {
        events.append(event)
        FileHelper.save(events)
    }
    
    func onSaveEdit (event:Event) {
        let eventIndex = events.firstIndex(where: {$0.id == event.id})
        if let index = eventIndex {
            events[index] = event
            FileHelper.save(events)
        }
    }
    
    var body: some View {
        NavigationStack {
            List($events, id: \.id) { $event in
                NavigationLink(value: event) {
                    if let index = events.firstIndex(where: { $0.id == event.id }) {
                        EventRow(event: $event)
                            .swipeActions {
                                Button(action: {
                                    events.remove(at: index)
                                    FileHelper.save(events)
                                }) {
                                    Image(systemName: "trash")
                                }.tint(.red)
                            }
                    }

                }
            }.navigationDestination(for: Event.self) {
                event in
                EventForm(title: event.title, date: event.date, color: event.textColor, id: event.id, mode: EventMode.edit, onSave:onSaveEdit)
            }.navigationTitle("Events").toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EventForm(mode: EventMode.add, onSave: onSave), label: {
                        Image(systemName: "plus")
                    })
                    
                    
                }
            
            }

        }
    }
}

#Preview {
    EventsView()
}
