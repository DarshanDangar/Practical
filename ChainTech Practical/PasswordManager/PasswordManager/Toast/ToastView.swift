//
//  ToastView.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: style.iconFileName)
                .foregroundStyle(style.themeColor)
            
            Text(message)
                .font(.caption)
                .foregroundStyle(Color(.label))
            
            Spacer()
            
            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        //        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .overlay() {
            RoundedRectangle(cornerRadius: 8)
                .stroke(style.themeColor, lineWidth: 1)
                .opacity(0.6)
        }
        .padding(.horizontal)
    }
    
}

#Preview {
    ToastView(style: .success, message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
}
