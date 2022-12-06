//: [Previous](@previous)

import Foundation
import Combine
import _Concurrency

example(of: "Publisher") {
    // Create the notification
    let myNotification = Notification.Name("myNotification")

    // Create the publisher
    let publisher = NotificationCenter.default.publisher(for: myNotification)
    
    // Create the subscription
    let center = NotificationCenter.default
    
    let observer = center.addObserver(
        forName: myNotification,
        object: nil,
        queue: .main) { notification in
            print("Receive the notifiaction")
        }
    
    center.post(name: myNotification, object: nil)
    center.removeObserver(observer)
}

example(of: "Publisher - 2") {
    // Create the notification
    let myNotification = Notification.Name("myNotification")
    
    // Create the center
    let center = NotificationCenter.default

    // Create the Publisher
    let publisher = center.publisher(for: myNotification)
    
    // Create the subscription
    let subscription = publisher
        // .print("Publisher")
        .sink { notification in
            print("Receive the notification")
        }

    center.post(name: myNotification, object: nil)

    subscription.cancel()
}

//: [Next](@next)
