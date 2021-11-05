//
//  ShareSheet.swift
//  ShareSheet
//
//  Created by Bri on 11/3/21.
//

import SwiftUI

public extension View {
    func shareSheet(items: [Any], isPresented: Binding<Bool>, excludedActivityTypes: [UIActivity.ActivityType]? ) -> some View {
        self.modifier(ShareSheetModifer(isPresented: isPresented, items: items))
    }
}

public struct ShareSheetModifer: ViewModifier {
    @Binding public var isPresented: Bool
    @State public var items: [Any] = []

    public func body(content: Content) -> some View {
        content
            .contextMenu {
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
            .sheet(isPresented: $isPresented) {
                ActivityViewController(activityItems: $items)
            }
    }
}

public struct ActivityViewController: UIViewControllerRepresentable {

    @Binding public var activityItems: [Any]
    public var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems,
                                                  applicationActivities: nil)

        controller.excludedActivityTypes = excludedActivityTypes

        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}
