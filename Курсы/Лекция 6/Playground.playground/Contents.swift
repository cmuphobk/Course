
protocol Name {

    var name: String { get }

    func getName() -> String
}

extension Name {

    func getName() -> String {
        return self.name
    }

}

struct Student: Name {

    var name: String

}

struct Class {
    var students: [Student]

    var currentIndex: Int = 0
    var step: Int = 1

    init(students: [Student]) {
        self.students = students
    }
}


extension Class: Collection {

    var startIndex: Int {
        return 0
    }
    var endIndex: Int {
        return self.students.count
    }

    func index(after i: Int) -> Int {
        return i + self.step
    }

    subscript(index: Int) -> Student {
        return self.students[index]
    }

}

extension Class: Sequence, IteratorProtocol {
    
    mutating func next() -> Student? {
        let student = self.students.count > self.currentIndex ? self.students[self.currentIndex] : nil
        self.currentIndex += step
        return student
    }
    
//    func makeIterator() -> ClassIterator {
//        return ClassIterator(students: self.students, currentIndex: self.currentIndex, step: self.step)
//    }

}

//struct ClassIterator {
//
//    var students: [Student]
//    var currentIndex: Int
//    var step: Int
//
//}
//
//extension ClassIterator: IteratorProtocol {
//
//    mutating func next() -> Student? {
//        let student = self.students.count > self.currentIndex ? self.students[self.currentIndex] : nil
//        self.currentIndex += self.step
//        return student
//    }
//
//}



var classVar = Class(students: [Student(name: "noname0"), Student(name: "noname1"), Student(name: "noname2"), Student(name: "noname3")])

for student in classVar {
    print(student.name)
}

classVar.forEach { (student) in
    print(student.name)
}

var names = classVar.map { (student) -> String in
    return student.name
}
print(names)

print(classVar[0])

let pizzaJoint = "café​ pesto"
let firstCharacterIndex = pizzaJoint.startIndex
let fourthCharacterIndex = pizzaJoint.index(firstCharacterIndex, offsetBy: 3)
let fourthCharacter = pizzaJoint[fourthCharacterIndex]

if let firstSpace = pizzaJoint.firstIndex(of: " ") {
    let secondWordIndex = pizzaJoint.index(firstSpace, offsetBy: 1)
    let secondWord = pizzaJoint[secondWordIndex..<pizzaJoint.endIndex]
    print(secondWord)
}

var arr = pizzaJoint.split(separator: " ")
print(arr[1])

for i in pizzaJoint {
    print(i)
}

var arr2 = Array(pizzaJoint)

var s = pizzaJoint
s.insert(contentsOf: "foo: ", at: s.index(s.index(of: " ")!, offsetBy: 1))


var s1 = "a b c"
s1.hasPrefix("a")
s1.replaceSubrange(..<s1.endIndex, with: "c b a")

var closure: ((Int) -> (Bool))!

closure = { $0 % 2 == 0 }

closure(5)

class Temp {

    var s1 = "a b c"
    var closure1: (() -> (String))!

    init() {
        self.closure1 = {[weak self] in return self?.s1 ?? "" }
        self.closure1()
    }

}



