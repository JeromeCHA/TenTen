# TenTen

## Subject : Computer simulator
We want you to build a computer simulator that supports executing:

```
def print_tenten
print(multiply(101, 10))
end
print(1009)
print_tenten()

// result
# 1009 
# 1010
```

### Instructions
- `MULT`: Pop the 2 arguments from the stack, multiply them and push the result back to the stack 
- `CALL addr`: Set the program counter (PC) to `addr`
- `RET`: Pop address from stack and set PC to address
- `STOP`: Exit the program
- `PRINT`: Pop value from stack and print it 
- `PUSH arg`: Push argument to the stack

### The code should execute against:

```
PRINT_TENTEN_BEGIN = 50
MAIN_BEGIN = 0
def main

# Create new computer with a stack of 100 addresses
computer = Computer.new(100)

# Instructions for the print_tenten function
computer.set_address(PRINT_TENTEN_BEGIN).insert("MULT").insert("PRINT").insert("RET")

# The start of the main function
computer.set_address(MAIN_BEGIN).insert("PUSH", 1009).insert("PRINT")

# Return address for when print_tenten function finishes
computer.insert("PUSH", 6)

# Setup arguments and call print_tenten
computer.insert("PUSH", 101).insert("PUSH", 10).insert("CALL", PRINT_TENTEN_BEGIN)

# Stop the program
computer.insert("STOP")
computer.set_address(MAIN_BEGIN).execute()

end
main()
```

### Requirements
- iOS 9.0+
- Swift 3

### How does it work?

This project was developed with [VIPER architecture](https://www.objc.io/issues/13-architecture/viper/) + [RxSwift](https://github.com/ReactiveX/RxSwift).
I know that there is no need to use all of the previous stuff to solve this problem, but I think it is a good opportunity to show you my skills.

![viper](https://cdn-images-1.medium.com/max/800/1*0pN3BNTXfwKbf08lhwutag.png)

- View : the view controller

- Interactors : each instruction is an interactor (see above for the description)
    - MULTInteractor
    - CALLInteractor
    - RETInteractor
    - PRINTInteractor
    - STOPInteractor
    - PUSHInteractor

- Presenter : It will run the computer and call the specific interactor

- Entities : 
    - StackEntity : represents a stack
    - ComputerEntity : represents the computer
    
- Router : Will handle the redirections and the initialization of the VIPER Architecture

The problem in VIPER Architecture is that each interactor should notify the presenter. That means a lot of callbacks/delegates.
To avoid this, I used Rx. Therefore, each Interactor will emit an Observable object and the Presenter will be the Observer.

If you have any questions, improvements or encounter any issues, please feel free to ask me.

## TODO
- PRINTInteractor needs to be improve
- Now the program will execute all instructions and will stop with a STOPError, which is not very a good implementation of Rx.. So, I should improve the run() when RxSwift will have *RepeatWhen* !! ..
