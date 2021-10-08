import UIKit

// Objective 1: Palindrome function

print("Objective 1")


func checkPalindrome( n: Int ) -> Int {
    var count: Int = 0
    var palindromeArray = [Int]()
    for i in 0...n{
        let currentNumber = String(i)
        let len = currentNumber.count / 2
        var isPalindrome: Bool = true
            for j in 0..<len{
                let start = currentNumber.index(currentNumber.startIndex, offsetBy: j)
                let end = currentNumber.index(currentNumber.endIndex, offsetBy: (j * -1) - 1)

                if currentNumber[start] != currentNumber[end] {
                        isPalindrome = false
                }
            }
        if isPalindrome{
            count+=1
            palindromeArray.append(i)
        }
    }
    print("Palindrome numbers: ",palindromeArray)
    return  count
}

print("Total count of palindromes: ", checkPalindrome( n: 200 ) )


//------------------------------------------------------------------------------------------------------------------
// Objective 2: Sum of multiples of 3 and 5 but not both
print("\n\nObjective 2")

func sumMultiples3_5(N: Int) -> Int{
    var sum: Int = 0
    for i in 3..<N {
        if (i%3 == 0 && i%5 != 0) || (i%5 == 0 && i%3 != 0) {
            sum += i
        }
    }
    return sum
}

print("Sum of multiples of 3 and 5 is : ", sumMultiples3_5(N: 20))


//------------------------------------------------------------------------------------------------------------------
//Objective 3: Sum of squares of optional array using forEach
print("\n\nObjective 3")

func squaredSums(inputArray: [Int?]) -> Int{
    var sumOfSquares:Int = 0
    inputArray.forEach {number in
        if ((number ?? 3)%2==0){
            sumOfSquares = sumOfSquares + ((number ?? 0) * (number ?? 0))
        }
    }
    return sumOfSquares
}

let inputArray: [Int?] = [1,2,3,nil]
print("Squared sum of even elements: ", squaredSums(inputArray: inputArray))

//------------------------------------------------------------------------------------------------------------------
//Objective 4: Sum of squares of optional array using reduce and filter
print("\n\nObjective 4")

// Same input array as for objective 3
func squaredSums2(inputArray: [Int?]) -> Int{
    var sumOfSquares:Int = 0
    var filteredNumbers: [Int?]
    filteredNumbers = inputArray.filter { ($0 ?? 3) % 2 == 0 }
    let squaredNumbers = filteredNumbers.map { ($0 ?? 0) * ($0 ?? 0)}
    sumOfSquares = squaredNumbers.reduce(0) { $0 + $1 }
    
    return sumOfSquares
}

print("Squared sum of even elements using filter and reduce: ", squaredSums2(inputArray: inputArray))


//------------------------------------------------------------------------------------------------------------------
//Objective 5: Student struct with one method
print("\n\nObjective 5")

struct Student{
    var name: String
    var redId: Int
    var units: Int
    var gpa: Float
    
    func compute() -> Float{
        let result = Float(self.units) * self.gpa
        return result
    }
}

let student1=Student(name: "Tom", redId: 123456789, units: 9, gpa: 3.2)
print("Computed result : ", student1.compute())

//------------------------------------------------------------------------------------------------------------------
//Objective 6: Priority queue
print("\n\nObjective 6")

class PriorityQueue{
    var queue: [Student?]=[]
    var maxPriorityStudentAt: Int = 0
    
    func add(currentStudent: Student){
        queue.append(currentStudent)
    }
    
    func first() -> Student{
        var maxPriority: Float = 0
        var firstStudent: Student = Student(name: "Sample", redId: 999999999, units: 0, gpa: 0.0)
        for i in 0...queue.count - 1{
            let currentStudent = queue[i]
            if (currentStudent!.compute() > maxPriority){
                maxPriority = (currentStudent!.compute())
                firstStudent = currentStudent!
                maxPriorityStudentAt = i
            }
        }
        return firstStudent
    }
    
    func removeFirst() -> Student{
        let studentToRemove: Student = first()
        queue.remove(at: maxPriorityStudentAt)
        return studentToRemove
    }
}

let queueObj = PriorityQueue()
let student2 = Student(name: "Harry", redId: 987654321, units: 12, gpa: 2.9)
let student3 = Student(name: "Sam", redId: 321321321, units: 7, gpa: 3.5)
queueObj.add(currentStudent: student1)
queueObj.add(currentStudent: student2)
queueObj.add(currentStudent: student3)
print("\nPriority Queue\n",queueObj.queue)
print("\n",queueObj.removeFirst()," successfully removed from queue\n")
print("\nPriority Queue\n",queueObj.queue)

//------------------------------------------------------------------------------------------------------------------
//Objective 7
print("\n\nObjective 7")

func cost( iceCreamDictionary: Dictionary<String, String>  ) -> String{
    
    let price = Double(iceCreamDictionary["price"] ?? "0")
    let quantity = Double(iceCreamDictionary["quantity"] ?? "0")
    let cost: Double = (price ?? 0) * (quantity ?? 0)
    
    let finalCost: String = (cost==0.0) ? "0" : String(cost)
    
    return finalCost
}

let iceCreamA = ["name":"Mochie Green Tea", "quantity": "2", "price": "2.3"]
let iceCreamB = ["name":"Mochie Green Tea", "price": "2.3"]

print("Cost: ",cost(iceCreamDictionary: iceCreamA))
print("Cost: ",cost(iceCreamDictionary: iceCreamB))


//------------------------------------------------------------------------------------------------------------------
//Objective 8
print("\n\nObjective 8")

func quadTable(N: Int) {
    for k in 1...N{
        let computedValue = k * k + 3 * k - 1
        print("k=",k," k*k+3k-1 =",computedValue)
    }
}

quadTable(N: 3)


//------------------------------------------------------------------------------------------------------------------
//Objective 9
print("\n\nObjective 9")

func evaluate(_ N: Int, _ selfFunction: (Int) -> Double) -> [Double] {
    var evaluatedArray: [Double] = []
    for k in 0...N{
        evaluatedArray.append(compute(k: k))
    }
    return evaluatedArray
}

func compute(k: Int) -> Double{
        let computedValue = k * k + 3 * k - 1
        
    return Double(computedValue)
}

print(evaluate(3, compute))
