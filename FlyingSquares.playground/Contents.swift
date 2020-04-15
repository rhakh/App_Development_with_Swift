import UIKit
import PlaygroundSupport

let liveViewFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: liveViewFrame)

liveView.backgroundColor = .white

PlaygroundPage.current.liveView = liveView


let smallFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
let square = UIView(frame: smallFrame)

square.backgroundColor = .purple

liveView.addSubview(square)


/*
UIView.animate(withDuration: 3.0) {
    square.backgroundColor = .orange
    square.frame = CGRect(x: 150, y: 150, width: 200, height: 200)
}

UIView.animate(withDuration: 3.0) {
    square.backgroundColor = .purple
    square.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
}

UIView.animate(withDuration: 3.0, animations: {
    square.backgroundColor = .orange
    square.frame = CGRect(x: 150, y: 150, width: 200, height: 200)
}) { (_) -> Void in
    UIView.animate(withDuration: 3.0, animations: {
        square.backgroundColor = .purple
        square.frame = smallFrame
    })
}
*/

let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
let rotateTransform = CGAffineTransform(rotationAngle: .pi)
let translateTransform = CGAffineTransform(translationX: 200, y: 200)

/*
UIView.animate(withDuration: 3.0,
               delay: 2.0,
               options: [.repeat],
               animations:
            {
                square.backgroundColor = .orange
                square.frame = CGRect(x: 400, y: 400, width: 100, height: 100)
            },
               completion: nil)
*/

UIView.animate(withDuration: 2.0, animations: {
    square.backgroundColor = .orange
    
    let comboTransform = scaleTransform.concatenating(rotateTransform)
                                       .concatenating(translateTransform)
    
    square.transform = comboTransform
}, completion: { (_) in
    UIView.animate(withDuration: 2.0, animations: {
        square.transform = CGAffineTransform.identity
    })
})
