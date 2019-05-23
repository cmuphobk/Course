import UIKit

protocol Unknown {
    var name: String { get }
}

class A: Unknown {
    var a = "a"
    
    var name: String {
        return self.a
    }
}

class B: A {
    var b = "b"
    
    override var name: String {
        return self.b
    }
}

class C: A {
    var c = "c"
    
    override var name: String {
        return self.c
    }
}

var a = A()

var b = B()

var c = C()
//
//if let variable = b as? A {
//
//}

//if let variable = b as? A {
//    print(variable)
//}
//if let variable = c as? A {
//    print(variable)
//}
//if let variable = c as? Unknown {
//    variable.name
//}

let unknown: Unknown = c

if let variable = unknown as? A { // variable A
    print(variable.name)
} else if let variable = unknown as? B {
    print(variable.name)
} else if let variable = unknown as? C {
    print(variable.name)
} else {
    
}
//
let variable = unknown as? B //B?
//
//let variable = unknown as! B
//
//let variable = unknown as B

//let variable = unknown as? B
//if variable is B {
//    
//} else {
//    
//}

//Создаем UIBezierPath
let path = UIBezierPath()
//Передвигаемся в точку, добавляем линии или дуги (arc) к path
path.move(to: CGPoint(x:80, y:50))
path.addLine(to: CGPoint(x:140, y:150))
path.addLine(to: CGPoint(x:10, y:150))
//Close (закрываем) path (если вы хотите)
path.close()
//Теперь, когда path создана, устанавливаем атрибуты и обводим (stroke) / закрашиваем (fill)
UIColor.green.setFill() // заметьте, setFill - это метод UIColor​, а не UIBezierPath
UIColor.red.setStroke() // заметьте, setStroke - это метод UIColor​, а не UIBezierPath
path.lineWidth = 5.0 // linewidth - это свойство в UIBezierPath​, а не UIColor
path.fill() // fill - это метод в UIBezierPath
path.stroke() // stroke - это метод в UIBezierPath



let size = CGSize(width: 100, height: 100)
let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
UIBezierPath(roundedRect: rect, cornerRadius: 5)

let color = UIColor(red: 100.0/255.0,
                    green: 0.0/255.0,
                    blue: 0.0/255.0,
                    alpha: 1.0)

let text = NSAttributedString(string: "hello")// возможно, устанавливаем также атрибуты
let point = CGPoint(x: 0, y: 0)
text.draw(at: point) // или draw(in: CGRect)
let textSize: CGSize = text.size() // определяем сколько места будет занимать строка

let font = UIFont(name: "Helvetica", size: 36.0)!
let metrics = UIFontMetrics(forTextStyle: .largeTitle) // или UIFontMetrics.default
let fontToUse = metrics.scaledFont(for: font)
print(fontToUse)

let rect = CGRect(x: 0, y: 0, width: 30, height: 30)
let image: UIImage = UIImage()
image.draw(at: point) // левый верхний угол изображения в точке aCGPoint
image.draw(in: rect)
image.drawAsPattern(in: rect) //плиточное изображение в aCGRect

