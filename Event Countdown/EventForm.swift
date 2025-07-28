//
//  EventForm.swift
//  Event Countdown
//
//  Created by Abdulkareem Mashabi on 25/01/1447 AH.
//

import SwiftUI

struct EventForm: View {
    @State var title: String = ""
    @State var date = Date()
    @State var color = Color.blue
    var id:UUID = UUID()
    var mode: EventMode;
    var onSave: (Event) -> Void;
    @Environment(\.dismiss) private var dismiss
    
    private var pageTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit:
            return "Edit \(title)"
        }
    }
    
    var finalBody: some View {
        Form {
            Section() {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $date, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                ColorPicker("Text Color", selection: $color)
                
            }
        }.navigationTitle(pageTitle).navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    onSave(Event(id: id, title: title, date: date, textColor: color))
                    dismiss()
                }) {
                    Image(systemName: "checkmark")
                }.disabled(title.isEmpty)
            }
        
        }
    }
    
    var body: some View {
        if mode == .add {
            NavigationStack{
                finalBody
            }
        }
        else {
            finalBody
        }
    }
}

#Preview {
    EventForm(id:UUID(), mode: EventMode.add, onSave: {event in })
}
