// initialization
@256
D=A
@SP
M=D
// call Sys.init 0
@ReturnAddress.0
D=A
@SP
M=M+1
A=M-1
M=D
(Sys.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Sys.init
0;JMP
(ReturnAddress.0)
// file: Array.vm
// function Array.new 0
(Array.new)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue0
D;JGT
@LabelFalse0
D=0;JMP
(LabelTrue0)
D=-1
(LabelFalse0)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Array.new.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Array.new.IF_FALSE0
0;JMP
// label IF_TRUE0
(Array.new.IF_TRUE0)
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.1
D=A
@SP
M=M+1
A=M-1
M=D
(Sys.error.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Sys.error
0;JMP
(ReturnAddress.1)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Array.new.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.alloc 1
@ReturnAddress.2
D=A
@SP
M=M+1
A=M-1
M=D
(Memory.alloc.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Memory.alloc
0;JMP
(ReturnAddress.2)
// return
(.return)
@SP
AM=M-1
D=M
@R14
M=D
@ARG
D=M
@SP
M=D
@LCL
D=M
@R13
M=D
@R13
D=M
@4
D=D-A
A=D
D=M
@LCL
M=D
@R13
D=M
@3
D=D-A
A=D
D=M
@ARG
M=D
@R13
D=M
@2
D=D-A
A=D
D=M
@THIS
M=D
@R13
D=M
@1
D=D-A
A=D
D=M
@THAT
M=D
@R13
D=M
@5
D=D-A
A=D
D=M
@R13
M=D
@R14
D=M
@SP
M=M+1
A=M-1
M=D
@R13
A=M
0;JMP
// function Array.dispose 0
(Array.dispose)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.deAlloc 1
@ReturnAddress.3
D=A
@SP
M=M+1
A=M-1
M=D
(Memory.deAlloc.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Memory.deAlloc
0;JMP
(ReturnAddress.3)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Ball.vm
// function Ball.new 0
(Ball.new)
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// call Memory.alloc 1
@ReturnAddress.4
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.alloc.1
0;JMP
(ReturnAddress.4)
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 10
@THIS
D=M
@10
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 11
@THIS
D=M
@11
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 4
@ARG
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 12
@THIS
D=M
@12
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 5
@ARG
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 13
@THIS
D=M
@13
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 14
@THIS
D=M
@14
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.show 1
@ReturnAddress.5
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.show.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.show
0;JMP
(ReturnAddress.5)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Ball.dispose 0
(Ball.dispose)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.deAlloc 1
@ReturnAddress.6
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.deAlloc.1
0;JMP
(ReturnAddress.6)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Ball.show 0
(Ball.show)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// call Screen.setColor 1
@ReturnAddress.7
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.setColor.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Screen.setColor
0;JMP
(ReturnAddress.7)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.draw 1
@ReturnAddress.8
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.draw.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.draw
0;JMP
(ReturnAddress.8)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Ball.hide 0
(Ball.hide)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Screen.setColor 1
@ReturnAddress.9
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.9)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.draw 1
@ReturnAddress.10
D=A
@SP
M=M+1
A=M-1
M=D
@Ball.draw.1
0;JMP
(ReturnAddress.10)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Ball.draw 0
(Ball.draw)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.11
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.drawRectangle.4)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@9
D=D-A
@ARG
M=D
@Screen.drawRectangle
0;JMP
(ReturnAddress.11)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Ball.getLeft 0
(Ball.getLeft)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Ball.getRight 0
(Ball.getRight)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// return
@.return
0;JMP
// function Ball.setDestination 3
(Ball.setDestination)
@3
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.12
D=A
@SP
M=M+1
A=M-1
M=D
(Math.abs.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Math.abs
0;JMP
(ReturnAddress.12)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.13
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.13)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue1
D;JLT
@LabelFalse1
D=0;JMP
(LabelTrue1)
D=-1
(LabelFalse1)
@SP
A=M-1
M=D
// pop this 7
@THIS
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 7
@THIS
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Ball.setDestination.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Ball.setDestination.IF_FALSE0
0;JMP
// label IF_TRUE0
(Ball.setDestination.IF_TRUE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue2
D;JLT
@LabelFalse2
D=0;JMP
(LabelTrue2)
D=-1
(LabelFalse2)
@SP
A=M-1
M=D
// pop this 8
@THIS
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue3
D;JLT
@LabelFalse3
D=0;JMP
(LabelTrue3)
D=-1
(LabelFalse3)
@SP
A=M-1
M=D
// pop this 9
@THIS
D=M
@9
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Ball.setDestination.IF_END0
0;JMP
// label IF_FALSE0
(Ball.setDestination.IF_FALSE0)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue4
D;JLT
@LabelFalse4
D=0;JMP
(LabelTrue4)
D=-1
(LabelFalse4)
@SP
A=M-1
M=D
// pop this 8
@THIS
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue5
D;JLT
@LabelFalse5
D=0;JMP
(LabelTrue5)
D=-1
(LabelFalse5)
@SP
A=M-1
M=D
// pop this 9
@THIS
D=M
@9
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END0
(Ball.setDestination.IF_END0)
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.14
D=A
@SP
M=M+1
A=M-1
M=D
(Math.multiply.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Math.multiply
0;JMP
(ReturnAddress.14)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.15
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.15)
// pop this 5
@THIS
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Math.multiply 2
@ReturnAddress.16
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.16)
// pop this 6
@THIS
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Ball.move 0
(Ball.move)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.hide 1
@ReturnAddress.17
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.hide.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.hide
0;JMP
(ReturnAddress.17)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue6
D;JLT
@LabelFalse6
D=0;JMP
(LabelTrue6)
D=-1
(LabelFalse6)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Ball.move.IF_FALSE0
0;JMP
// label IF_TRUE0
(Ball.move.IF_TRUE0)
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 5
@THIS
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Ball.move.IF_END0
0;JMP
// label IF_FALSE0
(Ball.move.IF_FALSE0)
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 9
@THIS
D=M
@9
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Ball.move.IF_FALSE1
0;JMP
// label IF_TRUE1
(Ball.move.IF_TRUE1)
// push this 7
@THIS
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Ball.move.IF_FALSE2
0;JMP
// label IF_TRUE2
(Ball.move.IF_TRUE2)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END2
@Ball.move.IF_END2
0;JMP
// label IF_FALSE2
(Ball.move.IF_FALSE2)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END2
(Ball.move.IF_END2)
// goto IF_END1
@Ball.move.IF_END1
0;JMP
// label IF_FALSE1
(Ball.move.IF_FALSE1)
// push this 7
@THIS
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Ball.move.IF_FALSE3
0;JMP
// label IF_TRUE3
(Ball.move.IF_TRUE3)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END3
@Ball.move.IF_END3
0;JMP
// label IF_FALSE3
(Ball.move.IF_FALSE3)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END3
(Ball.move.IF_END3)
// label IF_END1
(Ball.move.IF_END1)
// label IF_END0
(Ball.move.IF_END0)
// push this 8
@THIS
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE4
D;JNE
// goto IF_FALSE4
@Ball.move.IF_FALSE4
0;JMP
// label IF_TRUE4
(Ball.move.IF_TRUE4)
// push this 7
@THIS
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE5
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE5
D;JNE
// goto IF_FALSE5
@Ball.move.IF_FALSE5
0;JMP
// label IF_TRUE5
(Ball.move.IF_TRUE5)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END5
@Ball.move.IF_END5
0;JMP
// label IF_FALSE5
(Ball.move.IF_FALSE5)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END5
(Ball.move.IF_END5)
// goto IF_END4
@Ball.move.IF_END4
0;JMP
// label IF_FALSE4
(Ball.move.IF_FALSE4)
// push this 7
@THIS
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE6
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE6
D;JNE
// goto IF_FALSE6
@Ball.move.IF_FALSE6
0;JMP
// label IF_TRUE6
(Ball.move.IF_TRUE6)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END6
@Ball.move.IF_END6
0;JMP
// label IF_FALSE6
(Ball.move.IF_FALSE6)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END6
(Ball.move.IF_END6)
// label IF_END4
(Ball.move.IF_END4)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 10
@THIS
D=M
@10
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue7
D;JGT
@LabelFalse7
D=0;JMP
(LabelTrue7)
D=-1
(LabelFalse7)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE7
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE7
D;JNE
// goto IF_FALSE7
@Ball.move.IF_FALSE7
0;JMP
// label IF_TRUE7
(Ball.move.IF_TRUE7)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop this 14
@THIS
D=M
@14
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 10
@THIS
D=M
@10
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE7
(Ball.move.IF_FALSE7)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 11
@THIS
D=M
@11
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue8
D;JLT
@LabelFalse8
D=0;JMP
(LabelTrue8)
D=-1
(LabelFalse8)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE8
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE8
D;JNE
// goto IF_FALSE8
@Ball.move.IF_FALSE8
0;JMP
// label IF_TRUE8
(Ball.move.IF_TRUE8)
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// pop this 14
@THIS
D=M
@14
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 11
@THIS
D=M
@11
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE8
(Ball.move.IF_FALSE8)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 12
@THIS
D=M
@12
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue9
D;JGT
@LabelFalse9
D=0;JMP
(LabelTrue9)
D=-1
(LabelFalse9)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE9
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE9
D;JNE
// goto IF_FALSE9
@Ball.move.IF_FALSE9
0;JMP
// label IF_TRUE9
(Ball.move.IF_TRUE9)
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// pop this 14
@THIS
D=M
@14
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 12
@THIS
D=M
@12
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE9
(Ball.move.IF_FALSE9)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 13
@THIS
D=M
@13
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue10
D;JLT
@LabelFalse10
D=0;JMP
(LabelTrue10)
D=-1
(LabelFalse10)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE10
@SP
AM=M-1
D=M
@Ball.move.IF_TRUE10
D;JNE
// goto IF_FALSE10
@Ball.move.IF_FALSE10
0;JMP
// label IF_TRUE10
(Ball.move.IF_TRUE10)
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// pop this 14
@THIS
D=M
@14
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 13
@THIS
D=M
@13
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE10
(Ball.move.IF_FALSE10)
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.show 1
@ReturnAddress.18
D=A
@SP
M=M+1
A=M-1
M=D
@Ball.show.1
0;JMP
(ReturnAddress.18)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 14
@THIS
D=M
@14
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Ball.bounce 5
(Ball.bounce)
@5
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.19
D=A
@SP
M=M+1
A=M-1
M=D
(Math.divide.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Math.divide
0;JMP
(ReturnAddress.19)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.20
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.20)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue11
D;JEQ
@LabelFalse11
D=0;JMP
(LabelTrue11)
D=-1
(LabelFalse11)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Ball.bounce.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Ball.bounce.IF_FALSE0
0;JMP
// label IF_TRUE0
(Ball.bounce.IF_TRUE0)
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Ball.bounce.IF_END0
0;JMP
// label IF_FALSE0
(Ball.bounce.IF_FALSE0)
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue12
D;JLT
@LabelFalse12
D=0;JMP
(LabelTrue12)
D=-1
(LabelFalse12)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue13
D;JEQ
@LabelFalse13
D=0;JMP
(LabelTrue13)
D=-1
(LabelFalse13)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue14
D;JLT
@LabelFalse14
D=0;JMP
(LabelTrue14)
D=-1
(LabelFalse14)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue15
D;JEQ
@LabelFalse15
D=0;JMP
(LabelTrue15)
D=-1
(LabelFalse15)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Ball.bounce.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Ball.bounce.IF_FALSE1
0;JMP
// label IF_TRUE1
(Ball.bounce.IF_TRUE1)
// push constant 20
@20
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END1
@Ball.bounce.IF_END1
0;JMP
// label IF_FALSE1
(Ball.bounce.IF_FALSE1)
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END1
(Ball.bounce.IF_END1)
// label IF_END0
(Ball.bounce.IF_END0)
// push this 14
@THIS
D=M
@14
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue16
D;JEQ
@LabelFalse16
D=0;JMP
(LabelTrue16)
D=-1
(LabelFalse16)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Ball.bounce.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Ball.bounce.IF_FALSE2
0;JMP
// label IF_TRUE2
(Ball.bounce.IF_TRUE2)
// push constant 506
@506
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 50
@50
D=A
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// call Math.multiply 2
@ReturnAddress.21
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.21)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.22
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.22)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.23
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.23)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END2
@Ball.bounce.IF_END2
0;JMP
// label IF_FALSE2
(Ball.bounce.IF_FALSE2)
// push this 14
@THIS
D=M
@14
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue17
D;JEQ
@LabelFalse17
D=0;JMP
(LabelTrue17)
D=-1
(LabelFalse17)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Ball.bounce.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Ball.bounce.IF_FALSE3
0;JMP
// label IF_TRUE3
(Ball.bounce.IF_TRUE3)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 50
@50
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.24
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.24)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.25
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.25)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.26
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.26)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END3
@Ball.bounce.IF_END3
0;JMP
// label IF_FALSE3
(Ball.bounce.IF_FALSE3)
// push this 14
@THIS
D=M
@14
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue18
D;JEQ
@LabelFalse18
D=0;JMP
(LabelTrue18)
D=-1
(LabelFalse18)
@SP
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@Ball.bounce.IF_TRUE4
D;JNE
// goto IF_FALSE4
@Ball.bounce.IF_FALSE4
0;JMP
// label IF_TRUE4
(Ball.bounce.IF_TRUE4)
// push constant 250
@250
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 25
@25
D=A
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// call Math.multiply 2
@ReturnAddress.27
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.27)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.28
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.28)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.29
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.29)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END4
@Ball.bounce.IF_END4
0;JMP
// label IF_FALSE4
(Ball.bounce.IF_FALSE4)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 25
@25
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.30
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.30)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.31
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.31)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.32
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.32)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END4
(Ball.bounce.IF_END4)
// label IF_END3
(Ball.bounce.IF_END3)
// label IF_END2
(Ball.bounce.IF_END2)
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.setDestination 3
@ReturnAddress.33
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.setDestination.3)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@8
D=D-A
@ARG
M=D
@Ball.setDestination
0;JMP
(ReturnAddress.33)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Bat.vm
// function Bat.new 0
(Bat.new)
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// call Memory.alloc 1
@ReturnAddress.34
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.alloc.1
0;JMP
(ReturnAddress.34)
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.show 1
@ReturnAddress.35
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.show.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.show
0;JMP
(ReturnAddress.35)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Bat.dispose 0
(Bat.dispose)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.deAlloc 1
@ReturnAddress.36
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.deAlloc.1
0;JMP
(ReturnAddress.36)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.show 0
(Bat.show)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// call Screen.setColor 1
@ReturnAddress.37
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.37)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.draw 1
@ReturnAddress.38
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.draw.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.draw
0;JMP
(ReturnAddress.38)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.hide 0
(Bat.hide)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Screen.setColor 1
@ReturnAddress.39
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.39)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.draw 1
@ReturnAddress.40
D=A
@SP
M=M+1
A=M-1
M=D
@Bat.draw.1
0;JMP
(ReturnAddress.40)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.draw 0
(Bat.draw)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.41
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.41)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.setDirection 0
(Bat.setDirection)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.getLeft 0
(Bat.getLeft)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Bat.getRight 0
(Bat.getRight)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// return
@.return
0;JMP
// function Bat.setWidth 0
(Bat.setWidth)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.hide 1
@ReturnAddress.42
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.hide.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.hide
0;JMP
(ReturnAddress.42)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.show 1
@ReturnAddress.43
D=A
@SP
M=M+1
A=M-1
M=D
@Bat.show.1
0;JMP
(ReturnAddress.43)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Bat.move 0
(Bat.move)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue19
D;JEQ
@LabelFalse19
D=0;JMP
(LabelTrue19)
D=-1
(LabelFalse19)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Bat.move.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Bat.move.IF_FALSE0
0;JMP
// label IF_TRUE0
(Bat.move.IF_TRUE0)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue20
D;JLT
@LabelFalse20
D=0;JMP
(LabelTrue20)
D=-1
(LabelFalse20)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Bat.move.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Bat.move.IF_FALSE1
0;JMP
// label IF_TRUE1
(Bat.move.IF_TRUE1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(Bat.move.IF_FALSE1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Screen.setColor 1
@ReturnAddress.44
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.44)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.45
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.45)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// call Screen.setColor 1
@ReturnAddress.46
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.46)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.47
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.47)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END0
@Bat.move.IF_END0
0;JMP
// label IF_FALSE0
(Bat.move.IF_FALSE0)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue21
D;JGT
@LabelFalse21
D=0;JMP
(LabelTrue21)
D=-1
(LabelFalse21)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Bat.move.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Bat.move.IF_FALSE2
0;JMP
// label IF_TRUE2
(Bat.move.IF_TRUE2)
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(Bat.move.IF_FALSE2)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Screen.setColor 1
@ReturnAddress.48
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.48)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.49
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.49)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// call Screen.setColor 1
@ReturnAddress.50
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.setColor.1
0;JMP
(ReturnAddress.50)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawRectangle 4
@ReturnAddress.51
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.51)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_END0
(Bat.move.IF_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Keyboard.vm
// function Keyboard.init 0
(Keyboard.init)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Keyboard.keyPressed 0
(Keyboard.keyPressed)
// push constant 24576
@24576
D=A
@SP
M=M+1
A=M-1
M=D
// call Memory.peek 1
@ReturnAddress.52
D=A
@SP
M=M+1
A=M-1
M=D
(Memory.peek.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Memory.peek
0;JMP
(ReturnAddress.52)
// return
@.return
0;JMP
// function Keyboard.readChar 2
(Keyboard.readChar)
@2
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.printChar 1
@ReturnAddress.53
D=A
@SP
M=M+1
A=M-1
M=D
(Output.printChar.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Output.printChar
0;JMP
(ReturnAddress.53)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label WHILE_EXP0
(Keyboard.readChar.WHILE_EXP0)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue22
D;JEQ
@LabelFalse22
D=0;JMP
(LabelTrue22)
D=-1
(LabelFalse22)
@SP
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue23
D;JGT
@LabelFalse23
D=0;JMP
(LabelTrue23)
D=-1
(LabelFalse23)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Keyboard.readChar.WHILE_END0
D;JNE
// call Keyboard.keyPressed 0
@ReturnAddress.54
D=A
@SP
M=M+1
A=M-1
M=D
(Keyboard.keyPressed.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Keyboard.keyPressed
0;JMP
(ReturnAddress.54)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue24
D;JGT
@LabelFalse24
D=0;JMP
(LabelTrue24)
D=-1
(LabelFalse24)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Keyboard.readChar.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Keyboard.readChar.IF_FALSE0
0;JMP
// label IF_TRUE0
(Keyboard.readChar.IF_TRUE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Keyboard.readChar.IF_FALSE0)
// goto WHILE_EXP0
@Keyboard.readChar.WHILE_EXP0
0;JMP
// label WHILE_END0
(Keyboard.readChar.WHILE_END0)
// call String.backSpace 0
@ReturnAddress.55
D=A
@SP
M=M+1
A=M-1
M=D
(String.backSpace.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@String.backSpace
0;JMP
(ReturnAddress.55)
// call Output.printChar 1
@ReturnAddress.56
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printChar.1
0;JMP
(ReturnAddress.56)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.printChar 1
@ReturnAddress.57
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printChar.1
0;JMP
(ReturnAddress.57)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Keyboard.readLine 5
(Keyboard.readLine)
@5
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push constant 80
@80
D=A
@SP
M=M+1
A=M-1
M=D
// call String.new 1
@ReturnAddress.58
D=A
@SP
M=M+1
A=M-1
M=D
(String.new.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@String.new
0;JMP
(ReturnAddress.58)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.printString 1
@ReturnAddress.59
D=A
@SP
M=M+1
A=M-1
M=D
(Output.printString.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Output.printString
0;JMP
(ReturnAddress.59)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call String.newLine 0
@ReturnAddress.60
D=A
@SP
M=M+1
A=M-1
M=D
(String.newLine.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@String.newLine
0;JMP
(ReturnAddress.60)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// call String.backSpace 0
@ReturnAddress.61
D=A
@SP
M=M+1
A=M-1
M=D
@String.backSpace.0
0;JMP
(ReturnAddress.61)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Keyboard.readLine.WHILE_EXP0)
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Keyboard.readLine.WHILE_END0
D;JNE
// call Keyboard.readChar 0
@ReturnAddress.62
D=A
@SP
M=M+1
A=M-1
M=D
(Keyboard.readChar.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Keyboard.readChar
0;JMP
(ReturnAddress.62)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue25
D;JEQ
@LabelFalse25
D=0;JMP
(LabelTrue25)
D=-1
(LabelFalse25)
@SP
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Keyboard.readLine.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Keyboard.readLine.IF_FALSE0
0;JMP
// label IF_TRUE0
(Keyboard.readLine.IF_TRUE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue26
D;JEQ
@LabelFalse26
D=0;JMP
(LabelTrue26)
D=-1
(LabelFalse26)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Keyboard.readLine.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Keyboard.readLine.IF_FALSE1
0;JMP
// label IF_TRUE1
(Keyboard.readLine.IF_TRUE1)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call String.eraseLastChar 1
@ReturnAddress.63
D=A
@SP
M=M+1
A=M-1
M=D
(String.eraseLastChar.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@String.eraseLastChar
0;JMP
(ReturnAddress.63)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END1
@Keyboard.readLine.IF_END1
0;JMP
// label IF_FALSE1
(Keyboard.readLine.IF_FALSE1)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.64
D=A
@SP
M=M+1
A=M-1
M=D
(String.appendChar.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@String.appendChar
0;JMP
(ReturnAddress.64)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END1
(Keyboard.readLine.IF_END1)
// label IF_FALSE0
(Keyboard.readLine.IF_FALSE0)
// goto WHILE_EXP0
@Keyboard.readLine.WHILE_EXP0
0;JMP
// label WHILE_END0
(Keyboard.readLine.WHILE_END0)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Keyboard.readInt 2
(Keyboard.readInt)
@2
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Keyboard.readLine 1
@ReturnAddress.65
D=A
@SP
M=M+1
A=M-1
M=D
(Keyboard.readLine.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Keyboard.readLine
0;JMP
(ReturnAddress.65)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.intValue 1
@ReturnAddress.66
D=A
@SP
M=M+1
A=M-1
M=D
(String.intValue.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@String.intValue
0;JMP
(ReturnAddress.66)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.dispose 1
@ReturnAddress.67
D=A
@SP
M=M+1
A=M-1
M=D
(String.dispose.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@String.dispose
0;JMP
(ReturnAddress.67)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// file: Main.vm
// function Main.main 1
(Main.main)
@SP
M=M+1
A=M-1
M=0
A=A+1
// call PongGame.newInstance 0
@ReturnAddress.68
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.newInstance.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@PongGame.newInstance
0;JMP
(ReturnAddress.68)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call PongGame.getInstance 0
@ReturnAddress.69
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.getInstance.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@PongGame.getInstance
0;JMP
(ReturnAddress.69)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call PongGame.run 1
@ReturnAddress.70
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.run.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@PongGame.run
0;JMP
(ReturnAddress.70)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call PongGame.dispose 1
@ReturnAddress.71
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.dispose.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@PongGame.dispose
0;JMP
(ReturnAddress.71)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Math.vm
// function Math.init 1
(Math.init)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.72
D=A
@SP
M=M+1
A=M-1
M=D
(Array.new.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Array.new
0;JMP
(ReturnAddress.72)
// pop static 1
@SP
AM=M-1
D=M
@Math.1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.73
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.73)
// pop static 0
@SP
AM=M-1
D=M
@Math.0
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Math.init.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue27
D;JLT
@LabelFalse27
D=0;JMP
(LabelTrue27)
D=-1
(LabelFalse27)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Math.init.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Math.init.WHILE_EXP0
0;JMP
// label WHILE_END0
(Math.init.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Math.abs 0
(Math.abs)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue28
D;JLT
@LabelFalse28
D=0;JMP
(LabelTrue28)
D=-1
(LabelFalse28)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.abs.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.abs.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.abs.IF_TRUE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Math.abs.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Math.multiply 5
(Math.multiply)
@5
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue29
D;JLT
@LabelFalse29
D=0;JMP
(LabelTrue29)
D=-1
(LabelFalse29)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue30
D;JGT
@LabelFalse30
D=0;JMP
(LabelTrue30)
D=-1
(LabelFalse30)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue31
D;JGT
@LabelFalse31
D=0;JMP
(LabelTrue31)
D=-1
(LabelFalse31)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue32
D;JLT
@LabelFalse32
D=0;JMP
(LabelTrue32)
D=-1
(LabelFalse32)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.74
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.74)
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.75
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.75)
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue33
D;JLT
@LabelFalse33
D=0;JMP
(LabelTrue33)
D=-1
(LabelFalse33)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.multiply.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.multiply.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.multiply.IF_TRUE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Math.multiply.IF_FALSE0)
// label WHILE_EXP0
(Math.multiply.WHILE_EXP0)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue34
D;JLT
@LabelFalse34
D=0;JMP
(LabelTrue34)
D=-1
(LabelFalse34)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Math.multiply.WHILE_END0
D;JNE
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue35
D;JEQ
@LabelFalse35
D=0;JMP
(LabelTrue35)
D=-1
(LabelFalse35)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Math.multiply.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Math.multiply.IF_FALSE1
0;JMP
// label IF_TRUE1
(Math.multiply.IF_TRUE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(Math.multiply.IF_FALSE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Math.multiply.WHILE_EXP0
0;JMP
// label WHILE_END0
(Math.multiply.WHILE_END0)
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Math.multiply.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Math.multiply.IF_FALSE2
0;JMP
// label IF_TRUE2
(Math.multiply.IF_TRUE2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(Math.multiply.IF_FALSE2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Math.divide 4
(Math.divide)
@4
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue36
D;JEQ
@LabelFalse36
D=0;JMP
(LabelTrue36)
D=-1
(LabelFalse36)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.divide.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.divide.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.divide.IF_TRUE0)
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.76
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.76)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Math.divide.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue37
D;JLT
@LabelFalse37
D=0;JMP
(LabelTrue37)
D=-1
(LabelFalse37)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue38
D;JGT
@LabelFalse38
D=0;JMP
(LabelTrue38)
D=-1
(LabelFalse38)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue39
D;JGT
@LabelFalse39
D=0;JMP
(LabelTrue39)
D=-1
(LabelFalse39)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue40
D;JLT
@LabelFalse40
D=0;JMP
(LabelTrue40)
D=-1
(LabelFalse40)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.77
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.77)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.abs 1
@ReturnAddress.78
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.78)
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Math.divide.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue41
D;JLT
@LabelFalse41
D=0;JMP
(LabelTrue41)
D=-1
(LabelFalse41)
@SP
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Math.divide.WHILE_END0
D;JNE
// push constant 32767
@32767
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue42
D;JLT
@LabelFalse42
D=0;JMP
(LabelTrue42)
D=-1
(LabelFalse42)
@SP
A=M-1
M=D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Math.divide.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Math.divide.IF_FALSE1
0;JMP
// label IF_TRUE1
(Math.divide.IF_TRUE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue43
D;JGT
@LabelFalse43
D=0;JMP
(LabelTrue43)
D=-1
(LabelFalse43)
@SP
A=M-1
M=D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Math.divide.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Math.divide.IF_FALSE2
0;JMP
// label IF_TRUE2
(Math.divide.IF_TRUE2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(Math.divide.IF_FALSE2)
// label IF_FALSE1
(Math.divide.IF_FALSE1)
// goto WHILE_EXP0
@Math.divide.WHILE_EXP0
0;JMP
// label WHILE_END0
(Math.divide.WHILE_END0)
// label WHILE_EXP1
(Math.divide.WHILE_EXP1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue44
D;JGT
@LabelFalse44
D=0;JMP
(LabelTrue44)
D=-1
(LabelFalse44)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@Math.divide.WHILE_END1
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue45
D;JGT
@LabelFalse45
D=0;JMP
(LabelTrue45)
D=-1
(LabelFalse45)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Math.divide.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Math.divide.IF_FALSE3
0;JMP
// label IF_TRUE3
(Math.divide.IF_TRUE3)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Math.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE3
(Math.divide.IF_FALSE3)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP1
@Math.divide.WHILE_EXP1
0;JMP
// label WHILE_END1
(Math.divide.WHILE_END1)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@Math.divide.IF_TRUE4
D;JNE
// goto IF_FALSE4
@Math.divide.IF_FALSE4
0;JMP
// label IF_TRUE4
(Math.divide.IF_TRUE4)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE4
(Math.divide.IF_FALSE4)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Math.sqrt 4
(Math.sqrt)
@4
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue46
D;JLT
@LabelFalse46
D=0;JMP
(LabelTrue46)
D=-1
(LabelFalse46)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.sqrt.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.sqrt.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.sqrt.IF_TRUE0)
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.79
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.79)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Math.sqrt.IF_FALSE0)
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Math.sqrt.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue47
D;JGT
@LabelFalse47
D=0;JMP
(LabelTrue47)
D=-1
(LabelFalse47)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Math.sqrt.WHILE_END0
D;JNE
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Math.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.80
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.80)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue48
D;JGT
@LabelFalse48
D=0;JMP
(LabelTrue48)
D=-1
(LabelFalse48)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue49
D;JLT
@LabelFalse49
D=0;JMP
(LabelTrue49)
D=-1
(LabelFalse49)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Math.sqrt.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Math.sqrt.IF_FALSE1
0;JMP
// label IF_TRUE1
(Math.sqrt.IF_TRUE1)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(Math.sqrt.IF_FALSE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Math.sqrt.WHILE_EXP0
0;JMP
// label WHILE_END0
(Math.sqrt.WHILE_END0)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Math.max 0
(Math.max)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue50
D;JGT
@LabelFalse50
D=0;JMP
(LabelTrue50)
D=-1
(LabelFalse50)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.max.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.max.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.max.IF_TRUE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Math.max.IF_FALSE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Math.min 0
(Math.min)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue51
D;JLT
@LabelFalse51
D=0;JMP
(LabelTrue51)
D=-1
(LabelFalse51)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Math.min.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Math.min.IF_FALSE0
0;JMP
// label IF_TRUE0
(Math.min.IF_TRUE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Math.min.IF_FALSE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// file: Memory.vm
// function Memory.init 0
(Memory.init)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop static 0
@SP
AM=M-1
D=M
@Memory.0
M=D
// push constant 2048
@2048
D=A
@SP
M=M+1
A=M-1
M=D
// push static 0
@Memory.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 14334
@14334
D=A
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2049
@2049
D=A
@SP
M=M+1
A=M-1
M=D
// push static 0
@Memory.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 2050
@2050
D=A
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Memory.peek 0
(Memory.peek)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Memory.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Memory.poke 0
(Memory.poke)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Memory.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Memory.alloc 1
(Memory.alloc)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue52
D;JLT
@LabelFalse52
D=0;JMP
(LabelTrue52)
D=-1
(LabelFalse52)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Memory.alloc.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Memory.alloc.IF_FALSE0
0;JMP
// label IF_TRUE0
(Memory.alloc.IF_TRUE0)
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.81
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.81)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Memory.alloc.IF_FALSE0)
// push constant 2048
@2048
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Memory.alloc.WHILE_EXP0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue53
D;JLT
@LabelFalse53
D=0;JMP
(LabelTrue53)
D=-1
(LabelFalse53)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Memory.alloc.WHILE_END0
D;JNE
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Memory.alloc.WHILE_EXP0
0;JMP
// label WHILE_END0
(Memory.alloc.WHILE_END0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 16379
@16379
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue54
D;JGT
@LabelFalse54
D=0;JMP
(LabelTrue54)
D=-1
(LabelFalse54)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Memory.alloc.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Memory.alloc.IF_FALSE1
0;JMP
// label IF_TRUE1
(Memory.alloc.IF_TRUE1)
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.82
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.82)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE1
(Memory.alloc.IF_FALSE1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue55
D;JGT
@LabelFalse55
D=0;JMP
(LabelTrue55)
D=-1
(LabelFalse55)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Memory.alloc.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Memory.alloc.IF_FALSE2
0;JMP
// label IF_TRUE2
(Memory.alloc.IF_TRUE2)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue56
D;JEQ
@LabelFalse56
D=0;JMP
(LabelTrue56)
D=-1
(LabelFalse56)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Memory.alloc.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Memory.alloc.IF_FALSE3
0;JMP
// label IF_TRUE3
(Memory.alloc.IF_TRUE3)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END3
@Memory.alloc.IF_END3
0;JMP
// label IF_FALSE3
(Memory.alloc.IF_FALSE3)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END3
(Memory.alloc.IF_END3)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(Memory.alloc.IF_FALSE2)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// return
@.return
0;JMP
// function Memory.deAlloc 2
(Memory.deAlloc)
@2
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue57
D;JEQ
@LabelFalse57
D=0;JMP
(LabelTrue57)
D=-1
(LabelFalse57)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Memory.deAlloc.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Memory.deAlloc.IF_FALSE0
0;JMP
// label IF_TRUE0
(Memory.deAlloc.IF_TRUE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Memory.deAlloc.IF_END0
0;JMP
// label IF_FALSE0
(Memory.deAlloc.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue58
D;JEQ
@LabelFalse58
D=0;JMP
(LabelTrue58)
D=-1
(LabelFalse58)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Memory.deAlloc.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Memory.deAlloc.IF_FALSE1
0;JMP
// label IF_TRUE1
(Memory.deAlloc.IF_TRUE1)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END1
@Memory.deAlloc.IF_END1
0;JMP
// label IF_FALSE1
(Memory.deAlloc.IF_FALSE1)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END1
(Memory.deAlloc.IF_END1)
// label IF_END0
(Memory.deAlloc.IF_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Output.vm
// function Output.init 0
(Output.init)
// push constant 16384
@16384
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 4
@SP
AM=M-1
D=M
@Output.4
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// call String.new 1
@ReturnAddress.83
D=A
@SP
M=M+1
A=M-1
M=D
@String.new.1
0;JMP
(ReturnAddress.83)
// pop static 3
@SP
AM=M-1
D=M
@Output.3
M=D
// call Output.initMap 0
@ReturnAddress.84
D=A
@SP
M=M+1
A=M-1
M=D
(Output.initMap.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Output.initMap
0;JMP
(ReturnAddress.84)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Output.createShiftedMap 0
@ReturnAddress.85
D=A
@SP
M=M+1
A=M-1
M=D
(Output.createShiftedMap.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Output.createShiftedMap
0;JMP
(ReturnAddress.85)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.initMap 0
(Output.initMap)
// push constant 127
@127
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.86
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.86)
// pop static 5
@SP
AM=M-1
D=M
@Output.5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.87
D=A
@SP
M=M+1
A=M-1
M=D
(Output.create.12)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@17
D=D-A
@ARG
M=D
@Output.create
0;JMP
(ReturnAddress.87)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.88
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.88)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 33
@33
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.89
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.89)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 34
@34
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 20
@20
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.90
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.90)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.91
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.91)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 36
@36
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.92
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.92)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 37
@37
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 49
@49
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.93
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.93)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 38
@38
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.94
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.94)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 39
@39
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.95
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.95)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 40
@40
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.96
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.96)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 41
@41
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.97
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.97)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 42
@42
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.98
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.98)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 43
@43
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.99
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.99)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 44
@44
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.100
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.100)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 45
@45
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.101
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.101)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 46
@46
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.102
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.102)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 47
@47
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.103
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.103)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.104
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.104)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 49
@49
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.105
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.105)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 50
@50
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.106
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.106)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.107
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.107)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 52
@52
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 26
@26
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 25
@25
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 60
@60
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.108
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.108)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 53
@53
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.109
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.109)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.110
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.110)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 55
@55
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 49
@49
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.111
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.111)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 56
@56
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.112
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.112)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 57
@57
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 62
@62
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.113
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.113)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 58
@58
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.114
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.114)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.115
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.115)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 60
@60
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.116
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.116)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 61
@61
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.117
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.117)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 62
@62
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.118
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.118)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 64
@64
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.119
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.119)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.120
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.120)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 65
@65
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.121
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.121)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 66
@66
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.122
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.122)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 67
@67
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.123
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.123)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 68
@68
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.124
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.124)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 69
@69
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.125
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.125)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 70
@70
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.126
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.126)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 71
@71
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 44
@44
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.127
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.127)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 72
@72
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.128
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.128)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 73
@73
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.129
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.129)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 74
@74
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 60
@60
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.130
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.130)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 75
@75
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.131
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.131)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 76
@76
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.132
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.132)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 77
@77
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 33
@33
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.133
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.133)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 78
@78
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 55
@55
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 55
@55
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.134
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.134)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 79
@79
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.135
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.135)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 80
@80
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.136
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.136)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 81
@81
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 59
@59
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.137
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.137)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 82
@82
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.138
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.138)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 83
@83
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.139
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.139)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 84
@84
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 45
@45
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.140
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.140)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 85
@85
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.141
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.141)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 86
@86
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.142
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.142)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 87
@87
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.143
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.143)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 88
@88
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.144
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.144)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 89
@89
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.145
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.145)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 90
@90
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 49
@49
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 35
@35
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.146
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.146)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 91
@91
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.147
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.147)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 92
@92
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.148
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.148)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 93
@93
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.149
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.149)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 94
@94
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 8
@8
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.150
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.150)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 95
@95
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.151
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.151)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 96
@96
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.152
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.152)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 97
@97
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.153
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.153)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 98
@98
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.154
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.154)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 99
@99
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.155
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.155)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 100
@100
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 60
@60
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.156
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.156)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 101
@101
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.157
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.157)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 102
@102
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 38
@38
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.158
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.158)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 103
@103
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 62
@62
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.159
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.159)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 104
@104
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 55
@55
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.160
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.160)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 105
@105
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.161
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.161)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 106
@106
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 56
@56
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.162
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.162)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 107
@107
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.163
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.163)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 108
@108
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.164
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.164)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 109
@109
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 29
@29
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 43
@43
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 43
@43
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 43
@43
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 43
@43
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.165
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.165)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 110
@110
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 29
@29
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.166
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.166)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 111
@111
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.167
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.167)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 112
@112
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.168
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.168)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 113
@113
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 62
@62
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.169
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.169)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 114
@114
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 29
@29
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 55
@55
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.170
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.170)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 115
@115
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.171
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.171)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 116
@116
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 28
@28
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.172
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.172)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 117
@117
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 54
@54
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.173
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.173)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 118
@118
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.174
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.174)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 119
@119
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.175
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.175)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 120
@120
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 30
@30
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.176
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.176)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 121
@121
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 62
@62
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 24
@24
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.177
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.177)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 122
@122
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 51
@51
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.178
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.178)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 123
@123
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 56
@56
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 56
@56
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.179
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.179)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 124
@124
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.180
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.180)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 125
@125
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 56
@56
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.181
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.181)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 126
@126
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 38
@38
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 45
@45
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 25
@25
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.create 12
@ReturnAddress.182
D=A
@SP
M=M+1
A=M-1
M=D
@Output.create.12
0;JMP
(ReturnAddress.182)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.create 1
(Output.create)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.183
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.183)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 5
@Output.5
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 4
@ARG
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 5
@ARG
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 6
@ARG
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 7
@ARG
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 8
@ARG
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 8
@8
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 9
@ARG
D=M
@9
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 9
@9
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 10
@ARG
D=M
@10
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 11
@ARG
D=M
@11
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.createShiftedMap 4
(Output.createShiftedMap)
@4
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push constant 127
@127
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.184
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.184)
// pop static 6
@SP
AM=M-1
D=M
@Output.6
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Output.createShiftedMap.WHILE_EXP0)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 127
@127
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue59
D;JLT
@LabelFalse59
D=0;JMP
(LabelTrue59)
D=-1
(LabelFalse59)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Output.createShiftedMap.WHILE_END0
D;JNE
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 5
@Output.5
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.185
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.185)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 6
@Output.6
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP1
(Output.createShiftedMap.WHILE_EXP1)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue60
D;JLT
@LabelFalse60
D=0;JMP
(LabelTrue60)
D=-1
(LabelFalse60)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@Output.createShiftedMap.WHILE_END1
D;JNE
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 256
@256
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.186
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.186)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP1
@Output.createShiftedMap.WHILE_EXP1
0;JMP
// label WHILE_END1
(Output.createShiftedMap.WHILE_END1)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue61
D;JEQ
@LabelFalse61
D=0;JMP
(LabelTrue61)
D=-1
(LabelFalse61)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.createShiftedMap.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.createShiftedMap.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.createShiftedMap.IF_TRUE0)
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Output.createShiftedMap.IF_END0
0;JMP
// label IF_FALSE0
(Output.createShiftedMap.IF_FALSE0)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END0
(Output.createShiftedMap.IF_END0)
// goto WHILE_EXP0
@Output.createShiftedMap.WHILE_EXP0
0;JMP
// label WHILE_END0
(Output.createShiftedMap.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.getMap 1
(Output.getMap)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue62
D;JLT
@LabelFalse62
D=0;JMP
(LabelTrue62)
D=-1
(LabelFalse62)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 126
@126
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue63
D;JGT
@LabelFalse63
D=0;JMP
(LabelTrue63)
D=-1
(LabelFalse63)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.getMap.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.getMap.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.getMap.IF_TRUE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE0
(Output.getMap.IF_FALSE0)
// push static 2
@Output.2
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Output.getMap.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Output.getMap.IF_FALSE1
0;JMP
// label IF_TRUE1
(Output.getMap.IF_TRUE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 5
@Output.5
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END1
@Output.getMap.IF_END1
0;JMP
// label IF_FALSE1
(Output.getMap.IF_FALSE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 6
@Output.6
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END1
(Output.getMap.IF_END1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function Output.drawChar 4
(Output.drawChar)
@4
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.getMap 1
@ReturnAddress.187
D=A
@SP
M=M+1
A=M-1
M=D
(Output.getMap.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Output.getMap
0;JMP
(ReturnAddress.187)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Output.drawChar.WHILE_EXP0)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 11
@11
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue64
D;JLT
@LabelFalse64
D=0;JMP
(LabelTrue64)
D=-1
(LabelFalse64)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Output.drawChar.WHILE_END0
D;JNE
// push static 2
@Output.2
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.drawChar.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.drawChar.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.drawChar.IF_TRUE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 4
@Output.4
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 256
@256
D=A
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Output.drawChar.IF_END0
0;JMP
// label IF_FALSE0
(Output.drawChar.IF_FALSE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 4
@Output.4
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END0
(Output.drawChar.IF_END0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 4
@Output.4
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Output.drawChar.WHILE_EXP0
0;JMP
// label WHILE_END0
(Output.drawChar.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.moveCursor 0
(Output.moveCursor)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue65
D;JLT
@LabelFalse65
D=0;JMP
(LabelTrue65)
D=-1
(LabelFalse65)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 22
@22
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue66
D;JGT
@LabelFalse66
D=0;JMP
(LabelTrue66)
D=-1
(LabelFalse66)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue67
D;JLT
@LabelFalse67
D=0;JMP
(LabelTrue67)
D=-1
(LabelFalse67)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 63
@63
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue68
D;JGT
@LabelFalse68
D=0;JMP
(LabelTrue68)
D=-1
(LabelFalse68)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.moveCursor.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.moveCursor.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.moveCursor.IF_TRUE0)
// push constant 20
@20
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.188
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.188)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Output.moveCursor.IF_FALSE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.189
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.189)
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 352
@352
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.190
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.190)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.191
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.191)
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue69
D;JEQ
@LabelFalse69
D=0;JMP
(LabelTrue69)
D=-1
(LabelFalse69)
@SP
A=M-1
M=D
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call Output.drawChar 1
@ReturnAddress.192
D=A
@SP
M=M+1
A=M-1
M=D
(Output.drawChar.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Output.drawChar
0;JMP
(ReturnAddress.192)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.printChar 0
(Output.printChar)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.newLine 0
@ReturnAddress.193
D=A
@SP
M=M+1
A=M-1
M=D
@String.newLine.0
0;JMP
(ReturnAddress.193)
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue70
D;JEQ
@LabelFalse70
D=0;JMP
(LabelTrue70)
D=-1
(LabelFalse70)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.printChar.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.printChar.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.printChar.IF_TRUE0)
// call Output.println 0
@ReturnAddress.194
D=A
@SP
M=M+1
A=M-1
M=D
(Output.println.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Output.println
0;JMP
(ReturnAddress.194)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END0
@Output.printChar.IF_END0
0;JMP
// label IF_FALSE0
(Output.printChar.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.backSpace 0
@ReturnAddress.195
D=A
@SP
M=M+1
A=M-1
M=D
@String.backSpace.0
0;JMP
(ReturnAddress.195)
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue71
D;JEQ
@LabelFalse71
D=0;JMP
(LabelTrue71)
D=-1
(LabelFalse71)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Output.printChar.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Output.printChar.IF_FALSE1
0;JMP
// label IF_TRUE1
(Output.printChar.IF_TRUE1)
// call Output.backSpace 0
@ReturnAddress.196
D=A
@SP
M=M+1
A=M-1
M=D
(Output.backSpace.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Output.backSpace
0;JMP
(ReturnAddress.196)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END1
@Output.printChar.IF_END1
0;JMP
// label IF_FALSE1
(Output.printChar.IF_FALSE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.drawChar 1
@ReturnAddress.197
D=A
@SP
M=M+1
A=M-1
M=D
@Output.drawChar.1
0;JMP
(ReturnAddress.197)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push static 2
@Output.2
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Output.printChar.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Output.printChar.IF_FALSE2
0;JMP
// label IF_TRUE2
(Output.printChar.IF_TRUE2)
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// label IF_FALSE2
(Output.printChar.IF_FALSE2)
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue72
D;JEQ
@LabelFalse72
D=0;JMP
(LabelTrue72)
D=-1
(LabelFalse72)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Output.printChar.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Output.printChar.IF_FALSE3
0;JMP
// label IF_TRUE3
(Output.printChar.IF_TRUE3)
// call Output.println 0
@ReturnAddress.198
D=A
@SP
M=M+1
A=M-1
M=D
@Output.println.0
0;JMP
(ReturnAddress.198)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END3
@Output.printChar.IF_END3
0;JMP
// label IF_FALSE3
(Output.printChar.IF_FALSE3)
// push static 2
@Output.2
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// label IF_END3
(Output.printChar.IF_END3)
// label IF_END1
(Output.printChar.IF_END1)
// label IF_END0
(Output.printChar.IF_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.printString 2
(Output.printString)
@2
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.length 1
@ReturnAddress.199
D=A
@SP
M=M+1
A=M-1
M=D
(String.length.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@String.length
0;JMP
(ReturnAddress.199)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Output.printString.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue73
D;JLT
@LabelFalse73
D=0;JMP
(LabelTrue73)
D=-1
(LabelFalse73)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Output.printString.WHILE_END0
D;JNE
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.charAt 2
@ReturnAddress.200
D=A
@SP
M=M+1
A=M-1
M=D
(String.charAt.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@String.charAt
0;JMP
(ReturnAddress.200)
// call Output.printChar 1
@ReturnAddress.201
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printChar.1
0;JMP
(ReturnAddress.201)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Output.printString.WHILE_EXP0
0;JMP
// label WHILE_END0
(Output.printString.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.printInt 0
(Output.printInt)
// push static 3
@Output.3
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call String.setInt 2
@ReturnAddress.202
D=A
@SP
M=M+1
A=M-1
M=D
(String.setInt.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@String.setInt
0;JMP
(ReturnAddress.202)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push static 3
@Output.3
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.printString 1
@ReturnAddress.203
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printString.1
0;JMP
(ReturnAddress.203)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.println 0
(Output.println)
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 352
@352
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 8128
@8128
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue74
D;JEQ
@LabelFalse74
D=0;JMP
(LabelTrue74)
D=-1
(LabelFalse74)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.println.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.println.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.println.IF_TRUE0)
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// label IF_FALSE0
(Output.println.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Output.backSpace 0
(Output.backSpace)
// push static 2
@Output.2
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Output.backSpace.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Output.backSpace.IF_FALSE0
0;JMP
// label IF_TRUE0
(Output.backSpace.IF_TRUE0)
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue75
D;JGT
@LabelFalse75
D=0;JMP
(LabelTrue75)
D=-1
(LabelFalse75)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Output.backSpace.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Output.backSpace.IF_FALSE1
0;JMP
// label IF_TRUE1
(Output.backSpace.IF_TRUE1)
// push static 0
@Output.0
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// goto IF_END1
@Output.backSpace.IF_END1
0;JMP
// label IF_FALSE1
(Output.backSpace.IF_FALSE1)
// push constant 31
@31
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 0
@SP
AM=M-1
D=M
@Output.0
M=D
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue76
D;JEQ
@LabelFalse76
D=0;JMP
(LabelTrue76)
D=-1
(LabelFalse76)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Output.backSpace.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Output.backSpace.IF_FALSE2
0;JMP
// label IF_TRUE2
(Output.backSpace.IF_TRUE2)
// push constant 8128
@8128
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// label IF_FALSE2
(Output.backSpace.IF_FALSE2)
// push static 1
@Output.1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 321
@321
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop static 1
@SP
AM=M-1
D=M
@Output.1
M=D
// label IF_END1
(Output.backSpace.IF_END1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// goto IF_END0
@Output.backSpace.IF_END0
0;JMP
// label IF_FALSE0
(Output.backSpace.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop static 2
@SP
AM=M-1
D=M
@Output.2
M=D
// label IF_END0
(Output.backSpace.IF_END0)
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call Output.drawChar 1
@ReturnAddress.204
D=A
@SP
M=M+1
A=M-1
M=D
@Output.drawChar.1
0;JMP
(ReturnAddress.204)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: PongGame.vm
// function PongGame.new 0
(PongGame.new)
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// call Memory.alloc 1
@ReturnAddress.205
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.alloc.1
0;JMP
(ReturnAddress.205)
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// call Screen.clearScreen 0
@ReturnAddress.206
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.clearScreen.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Screen.clearScreen
0;JMP
(ReturnAddress.206)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 50
@50
D=A
@SP
M=M+1
A=M-1
M=D
// pop this 6
@THIS
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 230
@230
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 229
@229
D=A
@SP
M=M+1
A=M-1
M=D
// push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// call Bat.new 4
@ReturnAddress.207
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.new.4)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@9
D=D-A
@ARG
M=D
@Bat.new
0;JMP
(ReturnAddress.207)
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 253
@253
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 222
@222
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 229
@229
D=A
@SP
M=M+1
A=M-1
M=D
// call Ball.new 6
@ReturnAddress.208
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.new.6)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@11
D=D-A
@ARG
M=D
@Ball.new
0;JMP
(ReturnAddress.208)
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 400
@400
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Ball.setDestination 3
@ReturnAddress.209
D=A
@SP
M=M+1
A=M-1
M=D
@Ball.setDestination.3
0;JMP
(ReturnAddress.209)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push constant 238
@238
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 240
@240
D=A
@SP
M=M+1
A=M-1
M=D
// call Screen.drawRectangle 4
@ReturnAddress.210
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawRectangle.4
0;JMP
(ReturnAddress.210)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 22
@22
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Output.moveCursor 2
@ReturnAddress.211
D=A
@SP
M=M+1
A=M-1
M=D
(Output.moveCursor.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Output.moveCursor
0;JMP
(ReturnAddress.211)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 8
@8
D=A
@SP
M=M+1
A=M-1
M=D
// call String.new 1
@ReturnAddress.212
D=A
@SP
M=M+1
A=M-1
M=D
@String.new.1
0;JMP
(ReturnAddress.212)
// push constant 83
@83
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.213
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.213)
// push constant 99
@99
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.214
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.214)
// push constant 111
@111
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.215
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.215)
// push constant 114
@114
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.216
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.216)
// push constant 101
@101
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.217
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.217)
// push constant 58
@58
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.218
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.218)
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.219
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.219)
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.220
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.220)
// call Output.printString 1
@ReturnAddress.221
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printString.1
0;JMP
(ReturnAddress.221)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 5
@THIS
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function PongGame.dispose 0
(PongGame.dispose)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.dispose 1
@ReturnAddress.222
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.dispose.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.dispose
0;JMP
(ReturnAddress.222)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.dispose 1
@ReturnAddress.223
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.dispose.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.dispose
0;JMP
(ReturnAddress.223)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.deAlloc 1
@ReturnAddress.224
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.deAlloc.1
0;JMP
(ReturnAddress.224)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function PongGame.newInstance 0
(PongGame.newInstance)
// call PongGame.new 0
@ReturnAddress.225
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.new.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@PongGame.new
0;JMP
(ReturnAddress.225)
// pop static 0
@SP
AM=M-1
D=M
@PongGame.0
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function PongGame.getInstance 0
(PongGame.getInstance)
// push static 0
@PongGame.0
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function PongGame.run 1
(PongGame.run)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// label WHILE_EXP0
(PongGame.run.WHILE_EXP0)
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@PongGame.run.WHILE_END0
D;JNE
// label WHILE_EXP1
(PongGame.run.WHILE_EXP1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue77
D;JEQ
@LabelFalse77
D=0;JMP
(LabelTrue77)
D=-1
(LabelFalse77)
@SP
A=M-1
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@PongGame.run.WHILE_END1
D;JNE
// call Keyboard.keyPressed 0
@ReturnAddress.226
D=A
@SP
M=M+1
A=M-1
M=D
@Keyboard.keyPressed.0
0;JMP
(ReturnAddress.226)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.move 1
@ReturnAddress.227
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.move.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.move
0;JMP
(ReturnAddress.227)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call PongGame.moveBall 1
@ReturnAddress.228
D=A
@SP
M=M+1
A=M-1
M=D
(PongGame.moveBall.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@PongGame.moveBall
0;JMP
(ReturnAddress.228)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto WHILE_EXP1
@PongGame.run.WHILE_EXP1
0;JMP
// label WHILE_END1
(PongGame.run.WHILE_END1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 130
@130
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue78
D;JEQ
@LabelFalse78
D=0;JMP
(LabelTrue78)
D=-1
(LabelFalse78)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@PongGame.run.IF_TRUE0
D;JNE
// goto IF_FALSE0
@PongGame.run.IF_FALSE0
0;JMP
// label IF_TRUE0
(PongGame.run.IF_TRUE0)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// call Bat.setDirection 2
@ReturnAddress.229
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.setDirection.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Bat.setDirection
0;JMP
(ReturnAddress.229)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END0
@PongGame.run.IF_END0
0;JMP
// label IF_FALSE0
(PongGame.run.IF_FALSE0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 132
@132
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue79
D;JEQ
@LabelFalse79
D=0;JMP
(LabelTrue79)
D=-1
(LabelFalse79)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@PongGame.run.IF_TRUE1
D;JNE
// goto IF_FALSE1
@PongGame.run.IF_FALSE1
0;JMP
// label IF_TRUE1
(PongGame.run.IF_TRUE1)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// call Bat.setDirection 2
@ReturnAddress.230
D=A
@SP
M=M+1
A=M-1
M=D
@Bat.setDirection.2
0;JMP
(ReturnAddress.230)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END1
@PongGame.run.IF_END1
0;JMP
// label IF_FALSE1
(PongGame.run.IF_FALSE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 140
@140
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue80
D;JEQ
@LabelFalse80
D=0;JMP
(LabelTrue80)
D=-1
(LabelFalse80)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@PongGame.run.IF_TRUE2
D;JNE
// goto IF_FALSE2
@PongGame.run.IF_FALSE2
0;JMP
// label IF_TRUE2
(PongGame.run.IF_TRUE2)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(PongGame.run.IF_FALSE2)
// label IF_END1
(PongGame.run.IF_END1)
// label IF_END0
(PongGame.run.IF_END0)
// label WHILE_EXP2
(PongGame.run.WHILE_EXP2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue81
D;JEQ
@LabelFalse81
D=0;JMP
(LabelTrue81)
D=-1
(LabelFalse81)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END2
@SP
AM=M-1
D=M
@PongGame.run.WHILE_END2
D;JNE
// call Keyboard.keyPressed 0
@ReturnAddress.231
D=A
@SP
M=M+1
A=M-1
M=D
@Keyboard.keyPressed.0
0;JMP
(ReturnAddress.231)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.move 1
@ReturnAddress.232
D=A
@SP
M=M+1
A=M-1
M=D
@Bat.move.1
0;JMP
(ReturnAddress.232)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call PongGame.moveBall 1
@ReturnAddress.233
D=A
@SP
M=M+1
A=M-1
M=D
@PongGame.moveBall.1
0;JMP
(ReturnAddress.233)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto WHILE_EXP2
@PongGame.run.WHILE_EXP2
0;JMP
// label WHILE_END2
(PongGame.run.WHILE_END2)
// goto WHILE_EXP0
@PongGame.run.WHILE_EXP0
0;JMP
// label WHILE_END0
(PongGame.run.WHILE_END0)
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@PongGame.run.IF_TRUE3
D;JNE
// goto IF_FALSE3
@PongGame.run.IF_FALSE3
0;JMP
// label IF_TRUE3
(PongGame.run.IF_TRUE3)
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 27
@27
D=A
@SP
M=M+1
A=M-1
M=D
// call Output.moveCursor 2
@ReturnAddress.234
D=A
@SP
M=M+1
A=M-1
M=D
@Output.moveCursor.2
0;JMP
(ReturnAddress.234)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 9
@9
D=A
@SP
M=M+1
A=M-1
M=D
// call String.new 1
@ReturnAddress.235
D=A
@SP
M=M+1
A=M-1
M=D
@String.new.1
0;JMP
(ReturnAddress.235)
// push constant 71
@71
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.236
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.236)
// push constant 97
@97
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.237
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.237)
// push constant 109
@109
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.238
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.238)
// push constant 101
@101
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.239
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.239)
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.240
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.240)
// push constant 79
@79
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.241
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.241)
// push constant 118
@118
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.242
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.242)
// push constant 101
@101
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.243
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.243)
// push constant 114
@114
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.244
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.244)
// call Output.printString 1
@ReturnAddress.245
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printString.1
0;JMP
(ReturnAddress.245)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE3
(PongGame.run.IF_FALSE3)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function PongGame.moveBall 5
(PongGame.moveBall)
@5
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.move 1
@ReturnAddress.246
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.move.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.move
0;JMP
(ReturnAddress.246)
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue82
D;JGT
@LabelFalse82
D=0;JMP
(LabelTrue82)
D=-1
(LabelFalse82)
@SP
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 5
@THIS
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue83
D;JEQ
@LabelFalse83
D=0;JMP
(LabelTrue83)
D=-1
(LabelFalse83)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@PongGame.moveBall.IF_TRUE0
D;JNE
// goto IF_FALSE0
@PongGame.moveBall.IF_FALSE0
0;JMP
// label IF_TRUE0
(PongGame.moveBall.IF_TRUE0)
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 5
@THIS
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.getLeft 1
@ReturnAddress.247
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.getLeft.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.getLeft
0;JMP
(ReturnAddress.247)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.getRight 1
@ReturnAddress.248
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.getRight.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Bat.getRight
0;JMP
(ReturnAddress.248)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.getLeft 1
@ReturnAddress.249
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.getLeft.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.getLeft
0;JMP
(ReturnAddress.249)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.getRight 1
@ReturnAddress.250
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.getRight.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Ball.getRight
0;JMP
(ReturnAddress.250)
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 4
@4
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue84
D;JEQ
@LabelFalse84
D=0;JMP
(LabelTrue84)
D=-1
(LabelFalse84)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@PongGame.moveBall.IF_TRUE1
D;JNE
// goto IF_FALSE1
@PongGame.moveBall.IF_FALSE1
0;JMP
// label IF_TRUE1
(PongGame.moveBall.IF_TRUE1)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue85
D;JGT
@LabelFalse85
D=0;JMP
(LabelTrue85)
D=-1
(LabelFalse85)
@SP
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue86
D;JLT
@LabelFalse86
D=0;JMP
(LabelTrue86)
D=-1
(LabelFalse86)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// pop this 3
@THIS
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 3
@THIS
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@PongGame.moveBall.IF_TRUE2
D;JNE
// goto IF_FALSE2
@PongGame.moveBall.IF_FALSE2
0;JMP
// label IF_TRUE2
(PongGame.moveBall.IF_TRUE2)
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue87
D;JLT
@LabelFalse87
D=0;JMP
(LabelTrue87)
D=-1
(LabelFalse87)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@PongGame.moveBall.IF_TRUE3
D;JNE
// goto IF_FALSE3
@PongGame.moveBall.IF_FALSE3
0;JMP
// label IF_TRUE3
(PongGame.moveBall.IF_TRUE3)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END3
@PongGame.moveBall.IF_END3
0;JMP
// label IF_FALSE3
(PongGame.moveBall.IF_FALSE3)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue88
D;JGT
@LabelFalse88
D=0;JMP
(LabelTrue88)
D=-1
(LabelFalse88)
@SP
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@PongGame.moveBall.IF_TRUE4
D;JNE
// goto IF_FALSE4
@PongGame.moveBall.IF_FALSE4
0;JMP
// label IF_TRUE4
(PongGame.moveBall.IF_TRUE4)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE4
(PongGame.moveBall.IF_FALSE4)
// label IF_END3
(PongGame.moveBall.IF_END3)
// push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 6
@THIS
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 6
@THIS
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Bat.setWidth 2
@ReturnAddress.251
D=A
@SP
M=M+1
A=M-1
M=D
(Bat.setWidth.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Bat.setWidth
0;JMP
(ReturnAddress.251)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 4
@THIS
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 22
@22
D=A
@SP
M=M+1
A=M-1
M=D
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// call Output.moveCursor 2
@ReturnAddress.252
D=A
@SP
M=M+1
A=M-1
M=D
@Output.moveCursor.2
0;JMP
(ReturnAddress.252)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push this 4
@THIS
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.printInt 1
@ReturnAddress.253
D=A
@SP
M=M+1
A=M-1
M=D
(Output.printInt.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Output.printInt
0;JMP
(ReturnAddress.253)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE2
(PongGame.moveBall.IF_FALSE2)
// label IF_FALSE1
(PongGame.moveBall.IF_FALSE1)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Ball.bounce 2
@ReturnAddress.254
D=A
@SP
M=M+1
A=M-1
M=D
(Ball.bounce.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Ball.bounce
0;JMP
(ReturnAddress.254)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(PongGame.moveBall.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: Screen.vm
// function Screen.init 1
(Screen.init)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push constant 16384
@16384
D=A
@SP
M=M+1
A=M-1
M=D
// pop static 1
@SP
AM=M-1
D=M
@Screen.1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop static 2
@SP
AM=M-1
D=M
@Screen.2
M=D
// push constant 17
@17
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.255
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.255)
// pop static 0
@SP
AM=M-1
D=M
@Screen.0
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Screen.init.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue89
D;JLT
@LabelFalse89
D=0;JMP
(LabelTrue89)
D=-1
(LabelFalse89)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.init.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Screen.init.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.init.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.clearScreen 1
(Screen.clearScreen)
@SP
M=M+1
A=M-1
M=0
A=A+1
// label WHILE_EXP0
(Screen.clearScreen.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 8192
@8192
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue90
D;JLT
@LabelFalse90
D=0;JMP
(LabelTrue90)
D=-1
(LabelFalse90)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.clearScreen.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Screen.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Screen.clearScreen.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.clearScreen.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.updateLocation 0
(Screen.updateLocation)
// push static 2
@Screen.2
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.updateLocation.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.updateLocation.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.updateLocation.IF_TRUE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Screen.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Screen.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END0
@Screen.updateLocation.IF_END0
0;JMP
// label IF_FALSE0
(Screen.updateLocation.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Screen.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push static 1
@Screen.1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END0
(Screen.updateLocation.IF_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.setColor 0
(Screen.setColor)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop static 2
@SP
AM=M-1
D=M
@Screen.2
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawPixel 3
(Screen.drawPixel)
@3
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue91
D;JLT
@LabelFalse91
D=0;JMP
(LabelTrue91)
D=-1
(LabelFalse91)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue92
D;JGT
@LabelFalse92
D=0;JMP
(LabelTrue92)
D=-1
(LabelFalse92)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue93
D;JLT
@LabelFalse93
D=0;JMP
(LabelTrue93)
D=-1
(LabelFalse93)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue94
D;JGT
@LabelFalse94
D=0;JMP
(LabelTrue94)
D=-1
(LabelFalse94)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawPixel.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawPixel.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawPixel.IF_TRUE0)
// push constant 7
@7
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.256
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.256)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Screen.drawPixel.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.257
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.257)
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.258
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.258)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.259
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.259)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.updateLocation 2
@ReturnAddress.260
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.updateLocation.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Screen.updateLocation
0;JMP
(ReturnAddress.260)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawConditional 0
(Screen.drawConditional)
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawConditional.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawConditional.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawConditional.IF_TRUE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawPixel 2
@ReturnAddress.261
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.drawPixel.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Screen.drawPixel
0;JMP
(ReturnAddress.261)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END0
@Screen.drawConditional.IF_END0
0;JMP
// label IF_FALSE0
(Screen.drawConditional.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawPixel 2
@ReturnAddress.262
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawPixel.2
0;JMP
(ReturnAddress.262)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_END0
(Screen.drawConditional.IF_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawLine 11
(Screen.drawLine)
@11
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue95
D;JLT
@LabelFalse95
D=0;JMP
(LabelTrue95)
D=-1
(LabelFalse95)
@SP
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue96
D;JGT
@LabelFalse96
D=0;JMP
(LabelTrue96)
D=-1
(LabelFalse96)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue97
D;JLT
@LabelFalse97
D=0;JMP
(LabelTrue97)
D=-1
(LabelFalse97)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue98
D;JGT
@LabelFalse98
D=0;JMP
(LabelTrue98)
D=-1
(LabelFalse98)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawLine.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawLine.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawLine.IF_TRUE0)
// push constant 8
@8
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.263
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.263)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Screen.drawLine.IF_FALSE0)
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Math.abs 1
@ReturnAddress.264
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.264)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Math.abs 1
@ReturnAddress.265
D=A
@SP
M=M+1
A=M-1
M=D
@Math.abs.1
0;JMP
(ReturnAddress.265)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue99
D;JLT
@LabelFalse99
D=0;JMP
(LabelTrue99)
D=-1
(LabelFalse99)
@SP
A=M-1
M=D
// pop local 6
@LCL
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue100
D;JLT
@LabelFalse100
D=0;JMP
(LabelTrue100)
D=-1
(LabelFalse100)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue101
D;JLT
@LabelFalse101
D=0;JMP
(LabelTrue101)
D=-1
(LabelFalse101)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Screen.drawLine.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Screen.drawLine.IF_FALSE1
0;JMP
// label IF_TRUE1
(Screen.drawLine.IF_TRUE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 2
@ARG
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 3
@ARG
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(Screen.drawLine.IF_FALSE1)
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Screen.drawLine.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Screen.drawLine.IF_FALSE2
0;JMP
// label IF_TRUE2
(Screen.drawLine.IF_TRUE2)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 8
@LCL
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue102
D;JGT
@LabelFalse102
D=0;JMP
(LabelTrue102)
D=-1
(LabelFalse102)
@SP
A=M-1
M=D
// pop local 7
@LCL
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END2
@Screen.drawLine.IF_END2
0;JMP
// label IF_FALSE2
(Screen.drawLine.IF_FALSE2)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 8
@LCL
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue103
D;JGT
@LabelFalse103
D=0;JMP
(LabelTrue103)
D=-1
(LabelFalse103)
@SP
A=M-1
M=D
// pop local 7
@LCL
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END2
(Screen.drawLine.IF_END2)
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.266
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.266)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 5
@LCL
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.267
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.267)
// pop local 9
@LCL
D=M
@9
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Math.multiply 2
@ReturnAddress.268
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.268)
// pop local 10
@LCL
D=M
@10
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawConditional 3
@ReturnAddress.269
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.drawConditional.3)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@8
D=D-A
@ARG
M=D
@Screen.drawConditional
0;JMP
(ReturnAddress.269)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label WHILE_EXP0
(Screen.drawLine.WHILE_EXP0)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue104
D;JLT
@LabelFalse104
D=0;JMP
(LabelTrue104)
D=-1
(LabelFalse104)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.drawLine.WHILE_END0
D;JNE
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue105
D;JLT
@LabelFalse105
D=0;JMP
(LabelTrue105)
D=-1
(LabelFalse105)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@Screen.drawLine.IF_TRUE3
D;JNE
// goto IF_FALSE3
@Screen.drawLine.IF_FALSE3
0;JMP
// label IF_TRUE3
(Screen.drawLine.IF_TRUE3)
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 9
@LCL
D=M
@9
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 5
@LCL
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END3
@Screen.drawLine.IF_END3
0;JMP
// label IF_FALSE3
(Screen.drawLine.IF_FALSE3)
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 10
@LCL
D=M
@10
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 5
@LCL
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@Screen.drawLine.IF_TRUE4
D;JNE
// goto IF_FALSE4
@Screen.drawLine.IF_FALSE4
0;JMP
// label IF_TRUE4
(Screen.drawLine.IF_TRUE4)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END4
@Screen.drawLine.IF_END4
0;JMP
// label IF_FALSE4
(Screen.drawLine.IF_FALSE4)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END4
(Screen.drawLine.IF_END4)
// label IF_END3
(Screen.drawLine.IF_END3)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawConditional 3
@ReturnAddress.270
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawConditional.3
0;JMP
(ReturnAddress.270)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto WHILE_EXP0
@Screen.drawLine.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.drawLine.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawRectangle 9
(Screen.drawRectangle)
@9
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue106
D;JGT
@LabelFalse106
D=0;JMP
(LabelTrue106)
D=-1
(LabelFalse106)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue107
D;JGT
@LabelFalse107
D=0;JMP
(LabelTrue107)
D=-1
(LabelFalse107)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue108
D;JLT
@LabelFalse108
D=0;JMP
(LabelTrue108)
D=-1
(LabelFalse108)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue109
D;JGT
@LabelFalse109
D=0;JMP
(LabelTrue109)
D=-1
(LabelFalse109)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue110
D;JLT
@LabelFalse110
D=0;JMP
(LabelTrue110)
D=-1
(LabelFalse110)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue111
D;JGT
@LabelFalse111
D=0;JMP
(LabelTrue111)
D=-1
(LabelFalse111)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawRectangle.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawRectangle.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawRectangle.IF_TRUE0)
// push constant 9
@9
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.271
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.271)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Screen.drawRectangle.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.272
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.272)
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.273
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.273)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 7
@LCL
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.274
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.274)
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.275
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.275)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 8
@LCL
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// not
@SP
A=M-1
M=!M
// pop local 6
@LCL
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 5
@LCL
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.276
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.276)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Screen.drawRectangle.WHILE_EXP0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue112
D;JGT
@LabelFalse112
D=0;JMP
(LabelTrue112)
D=-1
(LabelFalse112)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.drawRectangle.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue113
D;JEQ
@LabelFalse113
D=0;JMP
(LabelTrue113)
D=-1
(LabelFalse113)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Screen.drawRectangle.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Screen.drawRectangle.IF_FALSE1
0;JMP
// label IF_TRUE1
(Screen.drawRectangle.IF_TRUE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// call Screen.updateLocation 2
@ReturnAddress.277
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.277)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END1
@Screen.drawRectangle.IF_END1
0;JMP
// label IF_FALSE1
(Screen.drawRectangle.IF_FALSE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.updateLocation 2
@ReturnAddress.278
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.278)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP1
(Screen.drawRectangle.WHILE_EXP1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue114
D;JLT
@LabelFalse114
D=0;JMP
(LabelTrue114)
D=-1
(LabelFalse114)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@Screen.drawRectangle.WHILE_END1
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// call Screen.updateLocation 2
@ReturnAddress.279
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.279)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP1
@Screen.drawRectangle.WHILE_EXP1
0;JMP
// label WHILE_END1
(Screen.drawRectangle.WHILE_END1)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.updateLocation 2
@ReturnAddress.280
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.280)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_END1
(Screen.drawRectangle.IF_END1)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Screen.drawRectangle.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.drawRectangle.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawHorizontal 11
(Screen.drawHorizontal)
@11
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.min 2
@ReturnAddress.281
D=A
@SP
M=M+1
A=M-1
M=D
(Math.min.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Math.min
0;JMP
(ReturnAddress.281)
// pop local 7
@LCL
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.max 2
@ReturnAddress.282
D=A
@SP
M=M+1
A=M-1
M=D
(Math.max.2)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@7
D=D-A
@ARG
M=D
@Math.max
0;JMP
(ReturnAddress.282)
// pop local 8
@LCL
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue115
D;JGT
@LabelFalse115
D=0;JMP
(LabelTrue115)
D=-1
(LabelFalse115)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 256
@256
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue116
D;JLT
@LabelFalse116
D=0;JMP
(LabelTrue116)
D=-1
(LabelFalse116)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 512
@512
D=A
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue117
D;JLT
@LabelFalse117
D=0;JMP
(LabelTrue117)
D=-1
(LabelFalse117)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue118
D;JGT
@LabelFalse118
D=0;JMP
(LabelTrue118)
D=-1
(LabelFalse118)
@SP
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawHorizontal.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawHorizontal.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawHorizontal.IF_TRUE0)
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// call Math.max 2
@ReturnAddress.283
D=A
@SP
M=M+1
A=M-1
M=D
@Math.max.2
0;JMP
(ReturnAddress.283)
// pop local 7
@LCL
D=M
@7
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.min 2
@ReturnAddress.284
D=A
@SP
M=M+1
A=M-1
M=D
@Math.min.2
0;JMP
(ReturnAddress.284)
// pop local 8
@LCL
D=M
@8
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.285
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.285)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 7
@LCL
D=M
@7
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.286
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.286)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 9
@LCL
D=M
@9
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.287
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.287)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 8
@LCL
D=M
@8
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.288
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.288)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 10
@LCL
D=M
@10
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 9
@LCL
D=M
@9
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// not
@SP
A=M-1
M=!M
// pop local 5
@LCL
D=M
@5
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 10
@LCL
D=M
@10
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push static 0
@Screen.0
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 32
@32
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.289
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.289)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 6
@LCL
D=M
@6
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 6
@LCL
D=M
@6
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue119
D;JEQ
@LabelFalse119
D=0;JMP
(LabelTrue119)
D=-1
(LabelFalse119)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Screen.drawHorizontal.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Screen.drawHorizontal.IF_FALSE1
0;JMP
// label IF_TRUE1
(Screen.drawHorizontal.IF_TRUE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// call Screen.updateLocation 2
@ReturnAddress.290
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.290)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto IF_END1
@Screen.drawHorizontal.IF_END1
0;JMP
// label IF_FALSE1
(Screen.drawHorizontal.IF_FALSE1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 5
@LCL
D=M
@5
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.updateLocation 2
@ReturnAddress.291
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.291)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(Screen.drawHorizontal.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue120
D;JLT
@LabelFalse120
D=0;JMP
(LabelTrue120)
D=-1
(LabelFalse120)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.drawHorizontal.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// neg
@SP
A=M-1
M=-M
// call Screen.updateLocation 2
@ReturnAddress.292
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.292)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Screen.drawHorizontal.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.drawHorizontal.WHILE_END0)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.updateLocation 2
@ReturnAddress.293
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.updateLocation.2
0;JMP
(ReturnAddress.293)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_END1
(Screen.drawHorizontal.IF_END1)
// label IF_FALSE0
(Screen.drawHorizontal.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawSymetric 0
(Screen.drawSymetric)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Screen.drawHorizontal 3
@ReturnAddress.294
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.drawHorizontal.3)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@8
D=D-A
@ARG
M=D
@Screen.drawHorizontal
0;JMP
(ReturnAddress.294)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Screen.drawHorizontal 3
@ReturnAddress.295
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawHorizontal.3
0;JMP
(ReturnAddress.295)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawHorizontal 3
@ReturnAddress.296
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawHorizontal.3
0;JMP
(ReturnAddress.296)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 3
@ARG
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// call Screen.drawHorizontal 3
@ReturnAddress.297
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawHorizontal.3
0;JMP
(ReturnAddress.297)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Screen.drawCircle 3
(Screen.drawCircle)
@3
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue121
D;JLT
@LabelFalse121
D=0;JMP
(LabelTrue121)
D=-1
(LabelFalse121)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue122
D;JGT
@LabelFalse122
D=0;JMP
(LabelTrue122)
D=-1
(LabelFalse122)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue123
D;JLT
@LabelFalse123
D=0;JMP
(LabelTrue123)
D=-1
(LabelFalse123)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue124
D;JGT
@LabelFalse124
D=0;JMP
(LabelTrue124)
D=-1
(LabelFalse124)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Screen.drawCircle.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Screen.drawCircle.IF_FALSE0
0;JMP
// label IF_TRUE0
(Screen.drawCircle.IF_TRUE0)
// push constant 12
@12
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.298
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.298)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Screen.drawCircle.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue125
D;JLT
@LabelFalse125
D=0;JMP
(LabelTrue125)
D=-1
(LabelFalse125)
@SP
A=M-1
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 511
@511
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue126
D;JGT
@LabelFalse126
D=0;JMP
(LabelTrue126)
D=-1
(LabelFalse126)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue127
D;JLT
@LabelFalse127
D=0;JMP
(LabelTrue127)
D=-1
(LabelFalse127)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 255
@255
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue128
D;JGT
@LabelFalse128
D=0;JMP
(LabelTrue128)
D=-1
(LabelFalse128)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@Screen.drawCircle.IF_TRUE1
D;JNE
// goto IF_FALSE1
@Screen.drawCircle.IF_FALSE1
0;JMP
// label IF_TRUE1
(Screen.drawCircle.IF_TRUE1)
// push constant 13
@13
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.299
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.299)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE1
(Screen.drawCircle.IF_FALSE1)
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawSymetric 4
@ReturnAddress.300
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.drawSymetric.4)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@9
D=D-A
@ARG
M=D
@Screen.drawSymetric
0;JMP
(ReturnAddress.300)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label WHILE_EXP0
(Screen.drawCircle.WHILE_EXP0)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue129
D;JGT
@LabelFalse129
D=0;JMP
(LabelTrue129)
D=-1
(LabelFalse129)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Screen.drawCircle.WHILE_END0
D;JNE
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue130
D;JLT
@LabelFalse130
D=0;JMP
(LabelTrue130)
D=-1
(LabelFalse130)
@SP
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@Screen.drawCircle.IF_TRUE2
D;JNE
// goto IF_FALSE2
@Screen.drawCircle.IF_FALSE2
0;JMP
// label IF_TRUE2
(Screen.drawCircle.IF_TRUE2)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.301
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.301)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END2
@Screen.drawCircle.IF_END2
0;JMP
// label IF_FALSE2
(Screen.drawCircle.IF_FALSE2)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 2
@2
D=A
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// call Math.multiply 2
@ReturnAddress.302
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.302)
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 5
@5
D=A
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_END2
(Screen.drawCircle.IF_END2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Screen.drawSymetric 4
@ReturnAddress.303
D=A
@SP
M=M+1
A=M-1
M=D
@Screen.drawSymetric.4
0;JMP
(ReturnAddress.303)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// goto WHILE_EXP0
@Screen.drawCircle.WHILE_EXP0
0;JMP
// label WHILE_END0
(Screen.drawCircle.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// file: String.vm
// function String.new 0
(String.new)
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// call Memory.alloc 1
@ReturnAddress.304
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.alloc.1
0;JMP
(ReturnAddress.304)
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue131
D;JLT
@LabelFalse131
D=0;JMP
(LabelTrue131)
D=-1
(LabelFalse131)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.new.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.new.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.new.IF_TRUE0)
// push constant 14
@14
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.305
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.305)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.new.IF_FALSE0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue132
D;JGT
@LabelFalse132
D=0;JMP
(LabelTrue132)
D=-1
(LabelFalse132)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@String.new.IF_TRUE1
D;JNE
// goto IF_FALSE1
@String.new.IF_FALSE1
0;JMP
// label IF_TRUE1
(String.new.IF_TRUE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.306
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.306)
// pop this 1
@THIS
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(String.new.IF_FALSE1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop this 0
@THIS
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.dispose 0
(String.dispose)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue133
D;JGT
@LabelFalse133
D=0;JMP
(LabelTrue133)
D=-1
(LabelFalse133)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.dispose.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.dispose.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.dispose.IF_TRUE0)
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// call Array.dispose 1
@ReturnAddress.307
D=A
@SP
M=M+1
A=M-1
M=D
(Array.dispose.1)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@6
D=D-A
@ARG
M=D
@Array.dispose
0;JMP
(ReturnAddress.307)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.dispose.IF_FALSE0)
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// call Memory.deAlloc 1
@ReturnAddress.308
D=A
@SP
M=M+1
A=M-1
M=D
@Memory.deAlloc.1
0;JMP
(ReturnAddress.308)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function String.length 0
(String.length)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.charAt 0
(String.charAt)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue134
D;JLT
@LabelFalse134
D=0;JMP
(LabelTrue134)
D=-1
(LabelFalse134)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue135
D;JGT
@LabelFalse135
D=0;JMP
(LabelTrue135)
D=-1
(LabelFalse135)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue136
D;JEQ
@LabelFalse136
D=0;JMP
(LabelTrue136)
D=-1
(LabelFalse136)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.charAt.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.charAt.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.charAt.IF_TRUE0)
// push constant 15
@15
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.309
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.309)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.charAt.IF_FALSE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.setCharAt 0
(String.setCharAt)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue137
D;JLT
@LabelFalse137
D=0;JMP
(LabelTrue137)
D=-1
(LabelFalse137)
@SP
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue138
D;JGT
@LabelFalse138
D=0;JMP
(LabelTrue138)
D=-1
(LabelFalse138)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue139
D;JEQ
@LabelFalse139
D=0;JMP
(LabelTrue139)
D=-1
(LabelFalse139)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.setCharAt.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.setCharAt.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.setCharAt.IF_TRUE0)
// push constant 16
@16
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.310
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.310)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.setCharAt.IF_FALSE0)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 2
@ARG
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function String.appendChar 0
(String.appendChar)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue140
D;JEQ
@LabelFalse140
D=0;JMP
(LabelTrue140)
D=-1
(LabelFalse140)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.appendChar.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.appendChar.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.appendChar.IF_TRUE0)
// push constant 17
@17
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.311
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.311)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.appendChar.IF_FALSE0)
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push pointer 0
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.eraseLastChar 0
(String.eraseLastChar)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue141
D;JEQ
@LabelFalse141
D=0;JMP
(LabelTrue141)
D=-1
(LabelFalse141)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.eraseLastChar.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.eraseLastChar.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.eraseLastChar.IF_TRUE0)
// push constant 18
@18
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.312
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.312)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.eraseLastChar.IF_FALSE0)
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function String.intValue 5
(String.intValue)
@5
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue142
D;JEQ
@LabelFalse142
D=0;JMP
(LabelTrue142)
D=-1
(LabelFalse142)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.intValue.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.intValue.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.intValue.IF_TRUE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// label IF_FALSE0
(String.intValue.IF_FALSE0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 45
@45
D=A
@SP
M=M+1
A=M-1
M=D
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue143
D;JEQ
@LabelFalse143
D=0;JMP
(LabelTrue143)
D=-1
(LabelFalse143)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@String.intValue.IF_TRUE1
D;JNE
// goto IF_FALSE1
@String.intValue.IF_FALSE1
0;JMP
// label IF_TRUE1
(String.intValue.IF_TRUE1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop local 4
@LCL
D=M
@4
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(String.intValue.IF_FALSE1)
// label WHILE_EXP0
(String.intValue.WHILE_EXP0)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue144
D;JLT
@LabelFalse144
D=0;JMP
(LabelTrue144)
D=-1
(LabelFalse144)
@SP
A=M-1
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// and
@SP
AMD=M-1
D=M
A=A-1
M=M&D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@String.intValue.WHILE_END0
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue145
D;JLT
@LabelFalse145
D=0;JMP
(LabelTrue145)
D=-1
(LabelFalse145)
@SP
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 9
@9
D=A
@SP
M=M+1
A=M-1
M=D
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue146
D;JGT
@LabelFalse146
D=0;JMP
(LabelTrue146)
D=-1
(LabelFalse146)
@SP
A=M-1
M=D
// or
@SP
AMD=M-1
D=M
A=A-1
M=M|D
// not
@SP
A=M-1
M=!M
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@String.intValue.IF_TRUE2
D;JNE
// goto IF_FALSE2
@String.intValue.IF_FALSE2
0;JMP
// label IF_TRUE2
(String.intValue.IF_TRUE2)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.313
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.313)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(String.intValue.IF_FALSE2)
// goto WHILE_EXP0
@String.intValue.WHILE_EXP0
0;JMP
// label WHILE_END0
(String.intValue.WHILE_END0)
// push local 4
@LCL
D=M
@4
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@String.intValue.IF_TRUE3
D;JNE
// goto IF_FALSE3
@String.intValue.IF_FALSE3
0;JMP
// label IF_TRUE3
(String.intValue.IF_TRUE3)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE3
(String.intValue.IF_FALSE3)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.setInt 4
(String.setInt)
@4
D=A
@SP
M=M+D
A=M-D
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop pointer 0
@SP
AM=M-1
D=M
@THIS
M=D
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue147
D;JEQ
@LabelFalse147
D=0;JMP
(LabelTrue147)
D=-1
(LabelFalse147)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@String.setInt.IF_TRUE0
D;JNE
// goto IF_FALSE0
@String.setInt.IF_FALSE0
0;JMP
// label IF_TRUE0
(String.setInt.IF_TRUE0)
// push constant 19
@19
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.314
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.314)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(String.setInt.IF_FALSE0)
// push constant 6
@6
D=A
@SP
M=M+1
A=M-1
M=D
// call Array.new 1
@ReturnAddress.315
D=A
@SP
M=M+1
A=M-1
M=D
@Array.new.1
0;JMP
(ReturnAddress.315)
// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue148
D;JLT
@LabelFalse148
D=0;JMP
(LabelTrue148)
D=-1
(LabelFalse148)
@SP
A=M-1
M=D
// if-goto IF_TRUE1
@SP
AM=M-1
D=M
@String.setInt.IF_TRUE1
D;JNE
// goto IF_FALSE1
@String.setInt.IF_FALSE1
0;JMP
// label IF_TRUE1
(String.setInt.IF_TRUE1)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// neg
@SP
A=M-1
M=-M
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE1
(String.setInt.IF_FALSE1)
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP0
(String.setInt.WHILE_EXP0)
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue149
D;JGT
@LabelFalse149
D=0;JMP
(LabelTrue149)
D=-1
(LabelFalse149)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@String.setInt.WHILE_END0
D;JNE
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.divide 2
@ReturnAddress.316
D=A
@SP
M=M+1
A=M-1
M=D
@Math.divide.2
0;JMP
(ReturnAddress.316)
// pop local 1
@LCL
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// push argument 1
@ARG
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 10
@10
D=A
@SP
M=M+1
A=M-1
M=D
// call Math.multiply 2
@ReturnAddress.317
D=A
@SP
M=M+1
A=M-1
M=D
@Math.multiply.2
0;JMP
(ReturnAddress.317)
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 1
@LCL
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// pop argument 1
@ARG
D=M+1
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@String.setInt.WHILE_EXP0
0;JMP
// label WHILE_END0
(String.setInt.WHILE_END0)
// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// if-goto IF_TRUE2
@SP
AM=M-1
D=M
@String.setInt.IF_TRUE2
D;JNE
// goto IF_FALSE2
@String.setInt.IF_FALSE2
0;JMP
// label IF_TRUE2
(String.setInt.IF_TRUE2)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 45
@45
D=A
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label IF_FALSE2
(String.setInt.IF_FALSE2)
// push this 0
@THIS
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue150
D;JLT
@LabelFalse150
D=0;JMP
(LabelTrue150)
D=-1
(LabelFalse150)
@SP
A=M-1
M=D
// if-goto IF_TRUE3
@SP
AM=M-1
D=M
@String.setInt.IF_TRUE3
D;JNE
// goto IF_FALSE3
@String.setInt.IF_FALSE3
0;JMP
// label IF_TRUE3
(String.setInt.IF_TRUE3)
// push constant 19
@19
D=A
@SP
M=M+1
A=M-1
M=D
// call Sys.error 1
@ReturnAddress.318
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.318)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE3
(String.setInt.IF_FALSE3)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// eq
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue151
D;JEQ
@LabelFalse151
D=0;JMP
(LabelTrue151)
D=-1
(LabelFalse151)
@SP
A=M-1
M=D
// if-goto IF_TRUE4
@SP
AM=M-1
D=M
@String.setInt.IF_TRUE4
D;JNE
// goto IF_FALSE4
@String.setInt.IF_FALSE4
0;JMP
// label IF_TRUE4
(String.setInt.IF_TRUE4)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push constant 48
@48
D=A
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto IF_END4
@String.setInt.IF_END4
0;JMP
// label IF_FALSE4
(String.setInt.IF_FALSE4)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP1
(String.setInt.WHILE_EXP1)
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue152
D;JLT
@LabelFalse152
D=0;JMP
(LabelTrue152)
D=-1
(LabelFalse152)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@String.setInt.WHILE_END1
D;JNE
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push this 1
@THIS
A=M+1
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push that 0
@THAT
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// pop pointer 1
@SP
AM=M-1
D=M
@THAT
M=D
// push temp 0
@R5
D=M
@SP
M=M+1
A=M-1
M=D
// pop that 0
@THAT
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// push this 2
@THIS
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// add
@SP
AMD=M-1
D=M
A=A-1
M=M+D
// pop this 2
@THIS
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP1
@String.setInt.WHILE_EXP1
0;JMP
// label WHILE_END1
(String.setInt.WHILE_END1)
// label IF_END4
(String.setInt.IF_END4)
// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
M=M+1
A=M-1
M=D
// call Array.dispose 1
@ReturnAddress.319
D=A
@SP
M=M+1
A=M-1
M=D
@Array.dispose.1
0;JMP
(ReturnAddress.319)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function String.newLine 0
(String.newLine)
// push constant 128
@128
D=A
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.backSpace 0
(String.backSpace)
// push constant 129
@129
D=A
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// function String.doubleQuote 0
(String.doubleQuote)
// push constant 34
@34
D=A
@SP
M=M+1
A=M-1
M=D
// return
@.return
0;JMP
// file: Sys.vm
// function Sys.init 0
(Sys.init)
// call Memory.init 0
@ReturnAddress.320
D=A
@SP
M=M+1
A=M-1
M=D
(Memory.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Memory.init
0;JMP
(ReturnAddress.320)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Math.init 0
@ReturnAddress.321
D=A
@SP
M=M+1
A=M-1
M=D
(Math.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Math.init
0;JMP
(ReturnAddress.321)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Screen.init 0
@ReturnAddress.322
D=A
@SP
M=M+1
A=M-1
M=D
(Screen.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Screen.init
0;JMP
(ReturnAddress.322)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Output.init 0
@ReturnAddress.323
D=A
@SP
M=M+1
A=M-1
M=D
(Output.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Output.init
0;JMP
(ReturnAddress.323)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Keyboard.init 0
@ReturnAddress.324
D=A
@SP
M=M+1
A=M-1
M=D
(Keyboard.init.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Keyboard.init
0;JMP
(ReturnAddress.324)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Main.main 0
@ReturnAddress.325
D=A
@SP
M=M+1
A=M-1
M=D
(Main.main.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Main.main
0;JMP
(ReturnAddress.325)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Sys.halt 0
@ReturnAddress.326
D=A
@SP
M=M+1
A=M-1
M=D
(Sys.halt.0)
@LCL
D=M
@SP
M=M+1
A=M-1
M=D
@ARG
D=M
@SP
M=M+1
A=M-1
M=D
@THIS
D=M
@SP
M=M+1
A=M-1
M=D
@THAT
D=M
@SP
M=M+1
A=M-1
M=D
D=A+1
@LCL
M=D
@5
D=D-A
@ARG
M=D
@Sys.halt
0;JMP
(ReturnAddress.326)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Sys.halt 0
(Sys.halt)
// label WHILE_EXP0
(Sys.halt.WHILE_EXP0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// not
@SP
A=M-1
M=!M
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Sys.halt.WHILE_END0
D;JNE
// goto WHILE_EXP0
@Sys.halt.WHILE_EXP0
0;JMP
// label WHILE_END0
(Sys.halt.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Sys.wait 1
(Sys.wait)
@SP
M=M+1
A=M-1
M=0
A=A+1
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// lt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue153
D;JLT
@LabelFalse153
D=0;JMP
(LabelTrue153)
D=-1
(LabelFalse153)
@SP
A=M-1
M=D
// if-goto IF_TRUE0
@SP
AM=M-1
D=M
@Sys.wait.IF_TRUE0
D;JNE
// goto IF_FALSE0
@Sys.wait.IF_FALSE0
0;JMP
// label IF_TRUE0
(Sys.wait.IF_TRUE0)
// push constant 1
@SP
M=M+1
A=M-1
M=1
// call Sys.error 1
@ReturnAddress.327
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.error.1
0;JMP
(ReturnAddress.327)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// label IF_FALSE0
(Sys.wait.IF_FALSE0)
// label WHILE_EXP0
(Sys.wait.WHILE_EXP0)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue154
D;JGT
@LabelFalse154
D=0;JMP
(LabelTrue154)
D=-1
(LabelFalse154)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END0
@SP
AM=M-1
D=M
@Sys.wait.WHILE_END0
D;JNE
// push constant 50
@50
D=A
@SP
M=M+1
A=M-1
M=D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// label WHILE_EXP1
(Sys.wait.WHILE_EXP1)
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// gt
@SP
AMD=M-1
D=M
A=A-1
MD=M-D
@LabelTrue155
D;JGT
@LabelFalse155
D=0;JMP
(LabelTrue155)
D=-1
(LabelFalse155)
@SP
A=M-1
M=D
// not
@SP
A=M-1
M=!M
// if-goto WHILE_END1
@SP
AM=M-1
D=M
@Sys.wait.WHILE_END1
D;JNE
// push local 0
@LCL
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop local 0
@LCL
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP1
@Sys.wait.WHILE_EXP1
0;JMP
// label WHILE_END1
(Sys.wait.WHILE_END1)
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// push constant 1
@SP
M=M+1
A=M-1
M=1
// sub
@SP
AMD=M-1
D=M
A=A-1
M=M-D
// pop argument 0
@ARG
D=M
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D
// goto WHILE_EXP0
@Sys.wait.WHILE_EXP0
0;JMP
// label WHILE_END0
(Sys.wait.WHILE_END0)
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// function Sys.error 0
(Sys.error)
// push constant 3
@3
D=A
@SP
M=M+1
A=M-1
M=D
// call String.new 1
@ReturnAddress.328
D=A
@SP
M=M+1
A=M-1
M=D
@String.new.1
0;JMP
(ReturnAddress.328)
// push constant 69
@69
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.329
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.329)
// push constant 82
@82
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.330
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.330)
// push constant 82
@82
D=A
@SP
M=M+1
A=M-1
M=D
// call String.appendChar 2
@ReturnAddress.331
D=A
@SP
M=M+1
A=M-1
M=D
@String.appendChar.2
0;JMP
(ReturnAddress.331)
// call Output.printString 1
@ReturnAddress.332
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printString.1
0;JMP
(ReturnAddress.332)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push argument 0
@ARG
A=M
D=M
@SP
M=M+1
A=M-1
M=D
// call Output.printInt 1
@ReturnAddress.333
D=A
@SP
M=M+1
A=M-1
M=D
@Output.printInt.1
0;JMP
(ReturnAddress.333)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// call Sys.halt 0
@ReturnAddress.334
D=A
@SP
M=M+1
A=M-1
M=D
@Sys.halt.0
0;JMP
(ReturnAddress.334)
// pop temp 0
@SP
AM=M-1
D=M
@R5
M=D
// push constant 0
@SP
M=M+1
A=M-1
M=0
// return
@.return
0;JMP
// end loop
(END)
@END
0;JMP
