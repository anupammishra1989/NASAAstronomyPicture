//
//  DatePickerView.swift
//  NASAAstronomyPicture
//
//  Created by anupam mishra on 22/07/22.
//

import SwiftUI

struct DatePickerView: View {
    @State var searchDate = Date()
    let dateChanged: (_ date: Date) -> Void
    
    var body: some View {
        
            VStack {
                DatePicker(selection: Binding(get: {
                    self.searchDate
                }, set: { newVal in
                    self.searchDate = newVal
                    dateChanged(searchDate)
                }), in: ...Date(), displayedComponents: .date) {
                    Text(selectADateText)
                        .font(.headline)
                }
                .background(.bar)
            }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(dateChanged: {_ in})
    }
}
