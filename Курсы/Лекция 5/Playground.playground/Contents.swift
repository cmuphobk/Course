import UIKit

protocol Moveable {
    mutating func move(to point: CGPoint)
}

class Car: Moveable {
    func move(to point: CGPoint) {
        
    }
    func changeOil() {
        
    }
}

struct Shape: Moveable {
    mutating func move(to point: CGPoint) {
        
    }
    func draw() {
        
    }
}

var prius: Car = Car()
var square: Shape = Shape()

var thingToMove: Moveable = prius
thingToMove.move(to: CGPoint(x: 0.0, y: 0.0))

//thingToMove.changeOil()

thingToMove = square

var array: [Moveable] = [prius, square]

func slide(slider: Moveable) {
    var slider = slider
    let positionToSlideTo = CGPoint(x: 0.0, y: 0.0)
    slider.move(to: positionToSlideTo)
}

slide(slider: prius)
slide(slider: square)

protocol Slippery { }

func slipAndSlide(slipAndSlider: Moveable & Slippery) {
    
}

//slipAndSlide(slipAndSlider: thingToMove)



protocol New {
    var age: Int { get }
    var isNew: Bool { get set }
}

protocol Student {
    func number() -> Int
}

class Person {

    private var privateAge: Int = 0

    private var privateIsNew: Bool = true
    
}

extension Person: New {
    var age: Int {
        return self.privateAge
    }
    
    var isNew: Bool {
        get  {
            return self.privateIsNew
        }
        
        set {
            self.privateIsNew = newValue
        }
    }
}

extension Person: Student {
    func number() -> Int {
        return 0
    }
}

class NewPerson: Student {
    func number() -> Int {
        return 0
    }
}

class Class {

    var students: [Student]
    
    init(students: [Student]) {
        self.students = students
    }
}

var classOfStudents = Class(students: [Person(), NewPerson()])

