import Foundation
import Combine

class MyManager {
    init(
        myNotification : Notification.Name = Notification.Name("myNotification"),
        center: NotificationCenter = NotificationCenter.default
    ) {
        self.myNotification = myNotification
        self.center = center
    }

    var myNotification = Notification.Name("myNotification")
    
    var center = NotificationCenter.default
    
    func sendNotification() {
        center.post(name: myNotification, object: nil)
    }
}

class Worker {
    var myNotification = Notification.Name("myNotification")
    
    var center = NotificationCenter.default

    var publisher : NotificationCenter.Publisher?
    
    var anyCancellable : AnyCancellable?

    func addingPublisher() {
        publisher = center.publisher(for: myNotification, object: nil)
    }

    func addingSubscription() {
        anyCancellable = publisher?.sink(receiveValue: { _ in
            print("Worker received value")
        })
    }
}
