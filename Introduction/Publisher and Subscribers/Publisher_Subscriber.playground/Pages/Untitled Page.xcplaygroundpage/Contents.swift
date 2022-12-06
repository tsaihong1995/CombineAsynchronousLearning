import Foundation
import Combine
import _Concurrency

var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    // 1. Create a Notification
    let myNotification = Notification.Name("MyNotification")
    
    // 2. Access NotificationCenter's default value to a local constant.
//    let publisher = NotificationCenter.default
//        .publisher(for: myNotification)
    
    /*
     Note: When an event trigger, the notification center broadcast a notification.
     
     Publisher emits two kinds of event:
     1. Value, also referred to as element.
     2. A completion event
     */
    
    // 3. Get a handle to the default notification center.
    let center = NotificationCenter.default
    
    // 4. Add the observer
    let observer = center.addObserver(
        forName: myNotification,
        object: nil,
        queue: nil
    ) { notification in
        print("Notification Receive")
    }

    // 5. Post a notification with the corresponding name
    center.post(name: myNotification, object: nil)
    
    // 6. Removing the Observer
    center.removeObserver(observer)
}

example(of: "Publisher - 3") {
    /*
     Subscribing with sink(_: _:)
     */
    
    // My notification
    let myNotification = Notification.Name("myNotification")
    
    // Using the notification center
    let center = NotificationCenter.default
    
    // Creating publisher
    let publisher = center.publisher(for: myNotification, object: nil)
    
    // Creating subscriber
    let subscription = publisher
        .sink { _ in
            print("Received notification")
        }
    
    center.post(name: myNotification, object: nil)
    
    subscription.cancel()
}

/*
 
 Sink actually return two closures:
 1. Return the completion handler (Either success or failure)
 2. Handle the receiving value
 
 */

example(of: "Just") {
    let just = Just("Just emit once.")
    
    _ = just.sink(
        receiveCompletion: {
            print("Received completion", $0)
        }, receiveValue: { value in
            print("Received the value \(value)")
        })
}

example(of: "Assign To") {
    // 1
    class SomeObject {
        var value: String = "" {
            didSet {
                print("Did set \(value)")
            }
        }
    }

    // 2
    let object = SomeObject()

    // 3
    let publisher = ["Hello", "World"].publisher

    // 4
    _ = publisher
        .assign(to: \.value, on: object)
}

example(of: "Assign To - 2") {
    class SomeObject {
        @Published var value = 0
    }

    let object = SomeObject()

    object.$value
        .sink { value in
            print("Received value : \(value)")
        }
    
    (0..<10).publisher
        .assign(to: &object.$value)
}


/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
