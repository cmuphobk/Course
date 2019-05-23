import UIKit


class Person {
    func personAge() {
        
        let s = stride(from: 0.5, to: 15.5, by: 0.3)
        for i in s {
            print(i)
        }
    }
}

var person = Person()
person.personAge()


enum FriOrderSize {
    case large
    case small
}

enum FastFoodMenuItem {
    case hamburger (numberOfPatties: Int)
    case fries (size: FriOrderSize)
    case drink (String, ml: Int) // неименованный String является брендом, например "Coke"
    case cookie
    
    func isIncludedInSpecialOrder (number: Int) -> Bool {
        
        switch self {
        case .hamburger (let pattyCount): return pattyCount == number
        case .fries , .cookie: return true // fries и cookie в каждом специальном заказе
        case .drink (_, let ml): return ml == 16 // любой напиток 16 унций
        }

    }
    
    mutating func switchToBeingCookie() {
        self = .cookie // это работает даже если self - это .hamburger, .fries или .drink
    }
    
    var calories : Int {
        // считаем и возвращаем кол-во калорий здесь
        return  0
    }
}


//var hamburger = FastFoodMenuItem.hamburger(numberOfPatties: 0)
//var hamburger1: FastFoodMenuItem = .hamburger(numberOfPatties: 1)
//var hamburger2 = .hamburger(numberOfPatties: 2)

//var menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)
//switch menuItem {
//case .hamburger (let numberOfPatties) : print ("burger \(numberOfPatties)")
//case .fries : print ("fries")
//case .drink : print ("drink")
//case .cookie : print ("cookie")
//}

var menuItem = FastFoodMenuItem.drink("Coke", ml: 500)
menuItem.isIncludedInSpecialOrder(number: 3)
menuItem.switchToBeingCookie()

switch menuItem {
case .hamburger (let pattyCount) :
    print("a burger with \(pattyCount) patties!")
    break
case .fries (let size) : print ("a \(size) order of fries!")
case .drink (let brand, let ounces) :
    print("a \(ounces)ml \(brand)")
    break
case .cookie : print ("cookie!")
}


var hello: String? = nil

//var hello: Optional<String> = Optional("some")

//switch hello {
//case .none:
//    print("none")
//case .some (let data):
//    print(data)
//}

if let helloUnwrap = hello {
    print(helloUnwrap)
} else {
    print("none")
}


if hello != nil {
    print(hello!)
}

//var hello1: String = "sd"
//var hello1: String?
var hello1: String!

//print(hello1.count)

hello1 = "a"

print(hello1.count)

//Optional chaining

var hello2: String?
