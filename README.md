# ASIC Design Class

# Table of contents
1. [Compilation of C code in GCC compiler](#Lab1A)
2. [Compilation of C code in RISC-V GCC compiler](#Lab1B)
3. [Execution of the output object file of RISC-V GCC compiler in Spike Simulator](#Lab2)
4. [Identify the various RISC-V instruction types and their 32-bit instruction codes](#Lab3)
5. [Execute the RISC-V ISA in the reference verilog code and get the output waveform](#Lab4)
6. [Create a C program for Caesar's data encryption and decryption algorithm. Execute the same in GCC and RISC-V GCC compiler.](#Lab5)
7. [Makerchip Platform and Digital Logic with TL-Verilog.](#Lab6)
8. [A basic micro-architecture for RISC-V CPU](#Lab7)
9. [3-Cycle Pipelined RISC-V CPU](#Lab8)
10. [Conversion of RISC-V CPU tlv code to verilog code](#Lab9)
11. [Tool Installation and BabySoC Simulation](#Lab10)
12. [RTL Design using Verilog and SKY130 Technology](#Lab11)
    1. [Introduction to Synthesis and Yosys](#Lab11_1)
    2. [RTL to netlist conversion using Yosys](#Lab11_2)
    3. [Introduction to SKY130 library file](#Lab11_3)
    4. [Hierarchial vs Flat Synthesis](#Lab11_4)
    5. [Flop Coding Styles and Optimizations](#Lab11_5)
    6. [Combinational and Sequential Optimizations](#Lab11_6)
    7. [GLS, Blocking v/s Non-Blocking and Synthesis-Simulation Mismatch](#Lab11_7)
13. [Risc-V Core Synthesis using Yosys and Post Synthesis BabySoc Simulation](#Lab12)
14. [Static Timing Analysis for Synthesized Risc-V Core using OpenSTA](#Lab13)

---
<a name="Lab1A"></a>

<details>
<summary>
Lab 1A: Create a small C program to count from 1 to n and compile it using GCC compiler.
</summary>

### Creation of a C program
Create a new your_file.c file in the desired directory in Linux environment.<br>
Here, I am using the nano text editor from Ubuntu.

<img src="images/Lab1A/step1_1.png" alt="Step 1.1" width="800"/><br>

Write and save your C program in the text editor.

It is a very simple C program to do the sum total of numbers from 1 to n where n is set to 100 in the code.

```
#include<stdio.h>

void main()
{
    int i, n = 100, sum = 0;
    for(i = 1; i<=n; ++i)
    {
        sum+=i;
    }
    printf("The sum of numbers starting from 1 till %d is: %d\n",n,sum);
}
```

<img src="images/Lab1A/step1_2.png" alt="Step 1.2" width="800"/><br>

### Compilation of C code using GCC compiler
Compile your code using gcc compiler in the terminal window of Ubuntu enivronment and make sure there are no errors during compilation.

```
gcc Lab1.c
```

<img src="images/Lab1A/step2.png" alt="Step 2" width="800"/><br>

### Step 3:
After compilation, the executable will be generated. Run the executable in terminal window to see the ouput.
```
./a.out
```

<img src="images/Lab1A/step3.png" alt="Step 3" width="800"/><br>

### Execution of the output file and result verification
In the below image we can observe the C code and the output together.

<img src="images/Lab1A/final_output.png" alt="Step 3" width="800"/><br><br>
</details>

---

<a name="Lab1B"></a>

<details>
<summary>
Lab 1B: Compile the same C program created as a part of Lab1A in RISC-V GCC compiler.
</summary>

### Introduction to RISC-V GCC

RISC-V GCC is a version of GCC that has been modified to support the RISC-V architecture.<br>The RISC-V architecture is an open standard instruction set architecture (ISA) based on established reduced instruction set computing (RISC) principles.

### Code Compilation using RISC-V GCC compiler
Compile the C code with riscv gcc compiler using the command shown below.
Here we are using the compiler flag as **-O1**.

```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o Lab1.o Lab1.c
```
Breaking dowm each of the parameters in the above command:

- riscv64: It specifies the target architecture (64 bit RISC-V)
- unknown: It is usually used to denote an unspecified vendor.
- elf: It specifies the target binary format.
- O1: It is the optimizaation flag.
- mabi=lp64: Is specifies application binary interface. lp64 means long and pointer are 64 bits wide in size.
- march=rv64i: ndicates the base RISC-V 64-bit integer instruction set.
- o Lab1.o: This specifies what should be the output object file name.
- Lab1.c : This is name of the C file which needs to be compiled.<br><br>


<img src="images/Lab1B/step1.png" alt="Step 1" width="800"/><br>

### Observe the assembly code generated in the object file post compilation
To see the dump of generated object file in assembly language, use the below command.

```
riscv64-unkown-elf-objdump -d Lab1.o | less
```

<img src="images/Lab1B/step2_1.png" alt="Step 2_1" width="800"/><br>

We can see the assembly language dump in the below screenshot.

<img src="images/Lab1B/step2_2.png" alt="Step 2_2" width="800"/><br>

For the "main" section, we can calculate the number of instructions either by counting each individual instruction in the main block.

 We can also subtract the address of the first instruction in the next section with the first instruction of the main section and divide the difference with 4 since it is a byte addressable memory, so 4 memory block form one instruction

E.g.: No. of instruction in main block = (0x101bc - 0x10184)/4 = 0x38/4 = 0xE = 14 instructions.

### Code Compilation using RISC-V GCC compiler with a different optimization flag (Ofast)
We will try to compile the code again with the compiler flag set as **-Ofast** and try to observe the generated assembly code.

```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o Lab1.o Lab1.c
```

<img src="images/Lab1B/step3_1.png" alt="Step 3_1" width="800"/><br>

Below is the screen shot of the assembly code generated with **-Ofast** compiler flag.

<img src="images/Lab1B/step3_2.png" alt="Step 3_2" width="800"/><br>

Here we can observe that the number of instructions are reduced to 6 as compared to 14 in the previous case.

---

### **Note:** Difference between **-O1** and **-Ofast** compiler flags:

- -O1 is moderate in it's code optimization while -Ofast is highly aggressive to achieve highest possible performance.
- -O1 maintains strict adherence to standards while -Ofast may violate some standards to achieve better performance.
- -O1 has shorter compilation time while -Ofast may have higher compilation time due to complex and many optimizations.
  
</details>

---

<a name="Lab2"></a>

<details>
<summary>
Lab 2: Execution of the object file created by the RISC-V GCC compiler using Spike Simulator.
</summary>

### Introduction to Spike Simulator

Spike is an Instruction Set Simulator(ISS). It serves as a starting point for running software on a RISC-V target. Below are the few main features of Spike:

- Supports multiple ISAs
- Multiple memory models
- Single-step debugging with support for viewing memory/register contents.
- Multiple CPU support
- JTAG support
- Highly extensible

### Execution of the object file using Spike simulator

To execute an object file created by the RISC-V GCC compiler, use the following command.

```
spike pk Lab1.o
```
Here in the above command, "pk" means proxy kernel.<br> The proxy kernel(pk) is a lightweight runtime environment for RISC-V programs, acting as a minimal operating system that provides essential services like system calls.<br> It helps to bridge the gap between simulator and application.

<img src="images/Lab2/step1.png" alt="Step 1" width="800"/><br>

We can observe from the above screenshot that the output from the GCC compiler and output from the RISC-V GCC compiler is same after executing the object files.

### Debugging using spike simulator

We can also debug the assembly code generated in the object file in using the spike.<br>Use the following command to go into debugging mode using spike:

```
spike -d pk Lab1.c
```

<img src="images/Lab2/step2_new.png" alt="Step 2" width="800"/><br>

To jump to begining of the "main" section, following command can be used:

```
until sp 0 0x100b0
```

'sp' denotes the stack pointer.<br><br> Using this command we are telling the debugger to execute the code starting from address 0 till address 0x100b0 which is the adress of the first instruction in the "main" section.<br>

<img src="images/Lab2/step3.png" alt="Step 3" width="800"/><br>

When the 'sp' is pointing to the first instruction of "main", we can start with line by line debugging and can try to check the register values.

Before we jump to next instruction, lets check the value of register $A2 since our 'sp' is pointing a operation where the value stored in $A2 register will be modified.<br>

To check any register value, following command can be used:

```
reg 0 a2
```
Here the '0' denotes the core.

<img src="images/Lab2/step4.png" alt="Step 4" width="800"/><br>

Now, to execute the current instruction pointed by 'sp' and come to the next instruction, "Enter" button can be pressed to go to next instruction.

<img src="images/Lab2/step5.png" alt="Step 5" width="800"/><br>

After coming to the next instruction, let's verify whether the "lui" operation changed the value stored in $A2 register.

<img src="images/Lab2/step6.png" alt="Step 5" width="800"/><br>

We can clearly observe that the value stored in $A2 register has changed after executing the "lui" operation.

---

### RISC-V 'LUI' ISA

'LUI' stands for Load Upper Immediate. It is a fundamental instruction used to load a 20-bit immediate value into the upper 20 bits of a 32-bit register, with the lower 12 bits set to zero. <br>

The LUI instruction format is:

```
LUI rd, imm
```

- rd: Destination register where the results will be stored.
- imm: The 20-bit immediate value to be loaded into the upper 20 bits of the destination register.

</details>

---


<details>
<summary>
<a name="Lab3"></a>
Lab 3: Identify the various RISC-V instruction types and their 32-bit instruction codes.
</summary>

<!-- 
### RISC-V RV32I Instructions

- In the base RV32I ISA, there are four core instruction formats (R/I/S/U).
- All core instructions are fixed 32 bits in length.
- The instructions are aligned on a 4-byte boundary in memory.
--- -->

### Different types of RV32I instruction formats

### 1. R-type Instruction

<img src="images/Lab3/R_Type.png" alt="Step 5" width="800"/><br>
Format for arithmetic and logical operations

R-type instructions are used for execution of operations between 2 registers.<br>

**rs1** is the source register 1 field. It is 5 bits wide.<br>
**rs2** is the source register 2 field. it is 5 bits wide.<br>
**rd** is the destination register field. It is 5 bits wide.<br>
The **opcode**(OP) value for R-Type instruction is **7'b0110011**.

| Instruction   | funct7 value | funct3 value |
| :-----------: | ------------ | ------------ |
|     ADD       | 7'b0000000   | 3'b000       |
|     SLT       | 7'b0000000   | 3'b010       |
|     SLTU      | 7'b0000000   | 3'b011       |
|     AND       | 7'b0000000   | 3'b111       |
|     OR        | 7'b0000000   | 3'b110       |
|     XOR       | 7'b0000000   | 3'b100       |
|     SLL       | 7'b0000000   | 3'b001       |
|     SRL       | 7'b0000000   | 3'b101       |
|     SRA       | 7'b0100000   | 3'b101       |
|     SUB       | 7'b0100000   | 3'b000       | 

---
### 2. I-type Instruction

<img src="images/Lab3/I_Type_Immediate.png" alt="Step 5" width="800"/><br>
Format for immediate operations

Operations use register and immediate values for execution.<br>
This instruction format is used in Immediate and Load operations.<br>
The opcode corresponding to the I-type instruction is named OP-IMM. It means immediate operation code.<br>
The immediate opcode OP-IMM is **7’b001_0011**.<br>

| Instruction   | funct3 value |
| :-----------: | ------------ |
|     ADDI      | 3'b000       |
|     SLTI      | 3'b010       |
|     SLTIU     | 3'b011       |
|     ANDI      | 3'b111       |
|     ORI       | 3'b110       |
|     XORI      | 3'b100       |

<img src="images/Lab3/I_Type_Shift.png" alt="Step 5" width="800"/><br>
Format for shift operations

| Instruction   | funct3 value |
| :-----------: | ------------ |
|     SLLI      | 3'b001       |
|     SRLI      | 3'b101       |
|     SRAI      | 3'b101       |

---
### 3. S-type Instruction

<img src="images/Lab3/S_Type_store.png" alt="Step 5" width="800"/><br>

In S-type instruction, 'S' stands for 'store'.<br>
It is store type instruction that helps to store the value of a register into the memory.<br>
In S-type instruction, there is no rd, i.e. destination register.<br>

The immediate field is divided into two parts, first part is in bits 11:5, and the second part is in bits 4:0.<br>

It stores a 32-bit value from register rs2 to memory, the effective address is obtained by adding register rs1 to the sign-extended 12-bit offset.

---
### 4. B-type Instruction

<img src="images/Lab3/B_Type.png" alt="Step 5" width="800"/><br>

In B-type instruction, 'B' stand for 'branching' which means it is mainly used for branching based on certain conditions.<br>

The instruction does not include rd register and funct7, but contains rs1, rs2, funct3 and immediate.<br>

There are two source registers rs1 and rs2 on which various operations are performed based on certain conditions, and those conditions are defined by func3 field.<br>

The immediate is divided into two areas.<br>
The 12-bit B-immediate encodes signed
offsets in multiples of 2 bytes.<br>

The offset is sign-extended and added to the address of the branch
instruction to give the target address.

The conditional branch range is ±4 KiB.<br>

---
### 32-bit format for various different instructions

```
ADD r7, r8, r9
```
> - R Type instruction since it's a register-register operation.
> - Adds the registers r8 and r9, stores the result in r7.
> - funct7 value for ADD operation is **7'b0000000**<br>
> rs1 = r8 = **5b'01000**<br>
> rs2 = r9 = **5b'01001**<br>
> funct3 value for ADD operation is **3b'000**<br>
> rd = r7 = **5b'00111**<br>
> Opcode for ADD is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_01001_01000_000_00111_0110011```
---
<br>

```
SUB r9, r7, r8
```
> - R Type instruction since it's a register-register operation.
> - Subtracts the registers r7 and r8, stores the result in r9.
> - funct7 value for SUB operation is **7'b0100000**<br>
> rs1 = r7 = **5b'00111**<br>
> rs2 = r8 = **5b'01000**<br>
> funct3 value for SUB operation is **3b'000**<br>
> rd = r9 = **5b'01001**<br>
> Opcode for SUB is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0100000_01000_00111_000_01001_0110011```
---
<br>

```
AND r8, r7, r9
```
> - R Type instruction since it's a register-register operation.
> - Performs bitwise AND operation between the registers r7 and r9, stores the result in r8.
> - funct7 value for AND operation is **7'b0000000**<br>
> rs1 = r7 = **5b'00111**<br>
> rs2 = r9 = **5b'01001**<br>
> funct3 value for AND operation is **3b'111**<br>
> rd = r8 = **5b'01000**<br>
> Opcode for AND is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_01001_00111_111_01000_0110011```
---
<br>

```
OR r8, r8, r5
```
> - R Type instruction since it's a register-register operation.
> - Performs bitwise OR operation between the registers r8 and r5, stores the result in r8.
> - funct7 value for AND operation is **7'b0000000**<br>
> rs1 = r8 = **5b'01000**<br>
> rs2 = r5 = **5b'00101**<br>
> funct3 value for AND operation is **3b'110**<br>
> rd = r8 = **5b'01000**<br>
> Opcode for OR is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_00101_01000_110_01000_0110011```
---

<br>

```
XOR r8, r7, r4
```
> - R Type instruction since it's a register-register operation.
> - Performs bitwise XOR operation between the registers r7 and r4, stores the result in r8.
> - funct7 value for AND operation is **7'b0000000**<br>
> rs1 = r7 = **5b'00111**<br>
> rs2 = r4 = **5b'00100**<br>
> funct3 value for AND operation is **3b'100**<br>
> rd = r8 = **5b'01000**<br>
> Opcode for XOR is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_00100_00111_100_01000_0110011```
---

<br>

```
SLT r10, r2, r4
```
> - R Type instruction since it's a register-register operation.
> - Place '1' in r10 register if r4 is less than r2, else place 0 in r10. Values in both r2 and r4 are treated as signed numbers.
> - funct7 value for AND operation is **7'b0000000**<br>
> rs1 = r2 = **5b'00010**<br>
> rs2 = r4 = **5b'00100**<br>
> funct3 value for SLT operation is **3b'010**<br>
> rd = r10 = **5b'01010**<br>
> Opcode for SLT is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_00100_00010_010_01010_0110011```
---

<br>

```
ADDI r12, r3, 5
```
> - I Type instruction since it's a register-immediate value operation.
> - Add r3 with immediate value(5), store in r12 register.
> - Immediate value = 5 = 12b'000000000101
> rs1 = r3 = **5b'00011**<br>
> funct3 value for ADDI operation is **3b'000**<br>
> rd = r12 = **5b'01100**<br>
> Opcode for ADDI is **7’b001_0011** since it's an I-type instruction.<br>

#### 32 bits instruction : ```000000000101_00011_000_01100_0010011```
---

<br>

```
SW r3, r1, 4
```
> - S Type instruction since it's a store operation
> - The source register is r3. Address will be obtained by adding immediate address value 4 with the address located in register r1.
> - Immediate value[11:0] = 4 = 12b'000000000100<br>
> rs2 = r3 = **5b'00011**<br>
> rs1 = r1 = **5b'00001**<br>
> funct3 value for SW operation is **3b'010**<br>
> Opcode for SW is **7’b010_0011** since it's an S-type instruction.<br>

#### 32 bits instruction : ```0000000_00011_00001_010_00100_0100011```
---

<br>

```
SRL r16, r11, r2
```
> - R Type instruction since it's a register-register operation.
> - Value in r11 register will be logical right shifted by the value stored in r2, result will be stored in r16 
> - funct7 value for ADD operation is **7'b0000000**<br>
> rs2 = r2 = **5b'00010**<br>
> rs1 = r11 = **5b'01011**<br>
> funct3 value for SRL operation is **3b'101**<br>
> rd = r16 = **5b'10000**<br>
> Opcode for SRL is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_00010_01011_101_10000_0110011```
---

<br>

```
BNE r0,r1,20
```
> - Since it's a branch operation, so B-type instruction.
> - If the register r0 and r1 are not equal, then take the branch.
> - if(r0 != r1) PC = PC + immediate = PC + 20
> - else PC = PC + 4
> - immediate = 20 = 000000010100
> rs1 = r0 = **5b'00000**<br>
> rs2 = r1 = **5b'00001**<br>
> imm[12] = 0 <br>
> imm[10:5] = 000001 <br>
> imm[11] = 0 <br>
> imm[4:1] 0100
> funct3 value for BNE operation is **3b'001**<br>
> Opcode for BNE is **7'b1100011** since it's an B-type instruction.<br>

#### 32 bits instruction : ```0_000001_00001_00000_001_0100_0_1100011```
---

<br>

```
BEQ r0,r0,15
```
> - Since it's a branch operation, so B-type instruction.
> - If the register r0 and r0 are equal, then take the branch.
> - if(r0 == r0) PC = PC + immediate = PC + 15
> - else PC = PC + 4
> - immediate = 15 = 000000001111
> rs1 = r0 = **5b'00000**<br>
> rs2 = r0 = **5b'00000**<br>
> imm[12] = 0 <br>
> imm[10:5] = 000000 <br>
> imm[11] = 0 <br>
> imm[4:1] 1111
> funct3 value for BEQ operation is **3b'000**<br>
> Opcode for BEQ is **7'b1100011** since it's an B-type instruction.<br>

#### 32 bits instruction : ```0_000000_00000_00000_000_1111_0_1100011```
---

<br>

```
LW r13, r11, 2
```
> - I-type instruction, since it's a load word operation 
> - Load the data from address stored in r11 plus offset added and store it in r13.
> - immediate = 2 = 000000000010
> rs1 = r11 = **5b'01011**<br>
> rd = r13 = **5b'01101**<br>
> funct3 value for LW operation is **3b'010**<br>
> Opcode for BEQ is **7'b0000011** since it's an I-type instruction.<br>

#### 32 bits instruction : ```000000000010_01011_010_01101_0000011```
---

<br>

```
SLL r15, r11, r2
```
> - R Type instruction since it's a register-register operation.
> - Value in r11 register will be logical right shifted by the value stored in r2, result will be stored in r15
> - funct7 value for ADD operation is **7'b0000000**<br>
> rs2 = r2 = **5b'00010**<br>
> rs1 = r11 = **5b'01011**<br>
> funct3 value for ADD operation is **3b'001**<br>
> rd = r7 = **5b'01111**<br>
> Opcode for ADD is **7'b0110011** since it's an R-type instruction.<br>

#### 32 bits instruction : ```0000000_00010_01011_001_01111_0110011```

</details>

---

<a name="Lab4"></a>

<details>
<summary>
Lab 4: Execute the RISC-V ISA in the reference verilog code and get the output waveform
</summary>

Below table shows the different instructions present in the reference verilog code:

|Operation	     | ISA          |             Bit Pattern                 |
|----------------|--------------|-----------------------------------------|
|ADD R6, R2, R1	 |32'h02208300  | 0000001 00010 00001 000 00110 0000000   |
|SUB R7, R1, R2	 |32'h02209380  | 0000001 00010 00001 001 00111 0000000   |
|AND R8, R1, R3	 |32'h0230a400  | 0000001 00011 00001 010 01000 0000000   |
|OR R9, R2, R5	 |32'h02513480  | 0000001 00101 00010 011 01001 0000000   |
|XOR R10, R1, R4 |32'h0240c500  | 0000001 00100 00001 100 01010 0000000   |
|SLT R1, R2, R4	 |32'h02415580  | 0000001 00100 00010 101 01011 0000000   |
|SRL R16, R14, R2|32'h00271803  | 0000000 00010 01110 001 10000 0000011   |
|SLL R15, R1, R2 |32'h00208783  | 0000000 00010 00001 000 01111 0000011   |
|ADDI R12, R4, 5 |32'h00520600  | 0000000000101 00100 000 01100 0000000   |
|LW R13, R1, 2	 |32'h00208681  | 0000000 00010 00001 000 01101 0000001   |
|BEQ R0, R0, 15	 |32'h00f00002  | 0 000000 01111 00000 000 0000 0 0000010 |
|SW R3, R1, 2	 |32'h00209181  | 0000000 00010 00001 001 00011 0000001   |

Below table shows different instructions listed in the previous task and their bit patters:

|Operation	     | ISA          |             Bit Pattern                 |
|----------------|--------------|-----------------------------------------|
|ADD R7, R8, R9	 |32'h009403B3  | 0000000 01001 01000 000 00111 0110011   |
|SUB R9, R7, R8	 |32'h408384B3  | 0100000 01000 00111 000 01001 0110011   |
|AND R8, R7, R9	 |32'h0093F433  | 0000000 01001 00111 111 01000 0110011   |
|OR R8, R8, R5	 |32'h00546433  | 0000000 00101 01000 110 01000 0110011   |
|XOR R8, R7, R4  |32'h0043C433  | 0000000 00100 00111 100 01000 0110011   |
|SLT R10, R2, R4 |32'h00412533  | 0000000 00100 00010 010 01010 0110011   |
|SRL R16, R11, R2|32'h0025D833  | 0000000 00010 01011 101 10000 0110011   |
|SLL R15, R11, R2|32'h002597B3  | 0000000 00010 01011 001 01111 0110011   |
|ADDI R12, R3, 5 |32'h00520600  | 0000000000101 00011 000 01100 0010011   |
|LW R13, R11, 2	 |32'h0025A683  | 0000000000010 01011 010 01101 0000011   |
|BEQ R0, R0, 15	 |32'h00000f63  | 0 000000 00000 00000 000 1111 0 1100011 |
|BNE R0, R1, 20	 |32'h02101463  | 0 000001 00001 00000 001 0100 0 1100011 |
|SW R3, R1, 2	 |32'h0030A223  | 0000000 00011 00001 010 00100 0100011   |


If we compare the above tables, we can observe that there are many differences between the bit pattern of different instruction formats.

For R-type format, we can observe differences in the opcode, funct7 and funct3 values.

For example, consider ADD operation:

Hardcoded: ADD R6, R2, R1: 0000001 00010 00001 000 00110 0000000
Standard RISC-V: ADD R7, R8, R9: 0000000 01001 01000 000 00111 0110011

We can observe that the bit pattern is different for **opcode**, **funct3** and **funct7**.

For other instructions, we can see similar differences in the standard RISC-V ISA bit pattern and the hardcoded ISA in the verilog code.

So, even if we try to execute our operations using the same verilog code, we may not get appropriate output as we would also need to modify the opcode, funct3 and funct7 values in the verilog code.

 ---

 ### Verilog output of the various RISC-V operations using the reference Verilog code

 Here, we will try to execute our list of operations in the reference verilog code by modifying the operation setting with those of our own operations.

  ---

 #### **Icarus Verilog and Gtkwave**

 Icarus Verilog, commonly referred to as IVerilog, is an open-source hardware description language (HDL) simulator used for the design and verification of digital circuits.

 GTKWave is a waveform viewer used in the design and verification of digital circuits.

 ---

 #### **Output waveform without any changes in the verilog code.**

 Below is the screenshot where we can observe the output waveform for different operations.

 <img src="images/Lab4/unmodified_waveform.png" alt="Unmodified_Waveform" width="800"/><br>

 ---

 #### **Modifications to operation lists in the verilog code.**

 Below, we can observe the modification in the operations in the verilog code.

 <img src="images/Lab4/verilog_operations_modification.png" alt="Differences" width="800"/><br>

 Left side is the non-modified verilog code, while in the right side, we have set our own operations.

#### 1. ADD r7, r8, r9

Operation : 32'h009403B3

<img src="images/Lab4/add_waveform.png" alt="ADD_Operation" width="800"/><br>

#### 2. SUB r9, r7, r8

Operation : 32'h408384B3

<img src="images/Lab4/sub_waveform.png" alt="SUB_Operation" width="800"/><br>

#### 3. AND r8, r7, r9

Operation : 32'h0093F433

<img src="images/Lab4/add_waveform.png" alt="AND_Operation" width="800"/><br>

#### 4. OR r8, r8, r5

Operation : 32'h00546433

<img src="images/Lab4/sub_waveform.png" alt="OR_Operation" width="800"/><br>

#### 5. XOR R8, R7, R4

Operation : 32'h0043C433

<img src="images/Lab4/xor_waveform.png" alt="XOR_Operation" width="800"/><br>

#### 6. SLT R10, R2, R4

Operation : 32'h00412533

<img src="images/Lab4/slt_waveform.png" alt="SLT_Operation" width="800"/><br>

#### 7. SRL R16, R11, R2

Operation : 32'h0025D833

<img src="images/Lab4/srl_waveform.png" alt="SRL_Operation" width="800"/><br>

#### 8. SLL R15, R11, R2

Operation : 32'h002597B3

<img src="images/Lab4/sll_waveform.png" alt="SLL_Operation" width="800"/><br>

#### 9. ADDI R12, R3, 5

Operation : 32'h00520600

<img src="images/Lab4/addi_waveform.png" alt="ADDI_Operation" width="800"/><br>

#### 10. LW R13, R11, 2

Operation : 32'h0025A683

<img src="images/Lab4/lw_waveform.png" alt="LW_Operation" width="800"/><br>

#### 11. BEQ R0, R0, 15

Operation : 32'h00000f63

<img src="images/Lab4/beq_waveform.png" alt="BEQ_Operation" width="800"/><br>

#### 12. BNE R0, R1, 20

Operation : 32'h02101463

<img src="images/Lab4/bne_waveform.png" alt="BNE_Operation" width="800"/><br>

#### 13. SW R3, R1, 2

Operation : 32'h0030A223

<img src="images/Lab4/sw_waveform.png" alt="SW_Operation" width="800"/><br>

</details>

---

<a name="Lab5"></a>

<details>
<summary>
Lab 5: Create a C program for Caesar's data encryption and decryption algorithm. Execute the same in GCC and RISC-V GCC compiler.
</summary>

### Caesar's encryption algorithm

The Caesar Cipher is one of the simplest and oldest methods of encrypting messages. This technique involves shifting the letters of the alphabet by a fixed number of places.

Despite its simplicity, the Caesar Cipher formed the groundwork for modern cryptographic techniques.

### Code for Caesar's encryption and decryption algorithm

```
#include<stdio.h>
#include<string.h>

// Function to encrypt the input string.
void Encrypt(char text[], int shift)
{
    for(int i =0; i < strlen(text); i++)
    {
        if(text[i] >= 'a' && text[i] <= 'z')
        {
            text[i] = ((text[i] - 'a' + shift) % 26) + 'a';
        }
        if(text[i] >= 'A' && text[i] <= 'Z')
        {
            text[i] = ((text[i] - 'A' + shift) % 26) + 'A';
        }
    }
}

// Function to decrypt the encrypted string.
void Decrypt(char text[], int shift)
{
    Encrypt(text, 26 - shift);
}

int main(void)
{
    char text[100] = "HelloWorld";
    int shift = 4;

    printf("Message before encryption: %s\n",text);

    Encrypt(text,shift);
    printf("Message after encryption: %s\n",text);

    Decrypt(text,shift);
    printf("Message after decryption: %s\n",text);

    return 0;
}
```

### Output for Caesar's Algorithm program from GCC compiler

In the below screenshot, we can observe the output of the Caesar Algorithm C program using GCC compiler.


<img src="images/Lab5/lab5_gcc.png" alt="Caesar_GCC" width="800"/><br>

### Output for Caesar's Algorithm program from RISC-V GCC compiler

In the below screenshot, we can observe the output of the Caesar Algorithm C program using RISC-V GCC compiler.

<img src="images/Lab5/lab5_riscv_gcc.png" alt="Caesar_RISCV_GCC" width="800"/><br>

### Results

If we compare the output from both GCC and RISC-V compilers, we can observe the same output from both which is expected.

---

### Assembly instructions for Caesar's algorithm from RISC-V GCC compiler.

Below snippet shows the assembly instruction for the **Encrypt** function

<img src="images/Lab5/lab5_riscv_assembly_encrypt.png" alt="Caesar_RISCV_GCC" width="800"/><br>

Below snippet shows the assembly instruction for the **Decrypt** function

<img src="images/Lab5/lab5_riscv_assembly_decrypt.png" alt="Caesar_RISCV_GCC" width="800"/><br>

Below snippet shows the assembly instruction for the **main** function

<img src="images/Lab5/lab5_riscv_assembly_main.png" alt="Caesar_RISCV_Assembly" width="800"/><br>

**Note** : All the instructions have been generated by compiling in the RISC-V compiler using the 'O1' flag.

</details>

---
<a name="Lab6"></a>

<details>
<summary>
Lab 6: Makerchip Platform and Digital Logic with TL-Verilog.
</summary>
[Makerchip](https://www.makerchip.com) is a free online platform to develop digital electronic circuits. We can develop circuits using TL Verilog directly in the browser. All steps of compilation, coding, debugging, visualization can be done in the same browser window.

Makerchip supports the emerging Transaction-Level Verilog standard. Transaction-Level Verilog, or [TL-Verilog](https://www.tl-x.org/), represents a huge step forward, by eliminating the need for the legacy language features of Verilog and by introducing simpler syntax. At the same time, TL-Verilog adds powerful constructs for pipelines and transactions.

### [Combinational Logic](tl_verilog_code/Calculator.tlv)

Here, we have implemented a basic combinational calculator. Below code snippet is the TL-Verilog code to implement the calculator on the Makerchip platform.

```
$val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];
   
   $sum[31:0] =  $val1[31:0] +  $val2[31:0];
   $diff[31:0] =  $val1[31:0] -  $val2[31:0];
   $prod[31:0] =  $val1[31:0] *  $val2[31:0];
   $quot[31:0] =  $val1[31:0] /  $val2[31:0];
   
   $out[31:0] = $sel[1] ? ($sel[0] ? $quot[31:0] : $prod[31:0])
                        : ($sel[0] ? $diff[31:0] : $sum[31:0]);
```


Below is a screenshot of the implementation of the above code for a basic combinational circuit in Makerchip platfrom. We can also observe the generated block diagram as well as the waveform for the simulation of our circuit.

<img src="images/Lab6/comb_ckt.png" alt="Makerchip_Comb_Ckt" width="800"/><br>

### [Sequential Logic](tl_verilog_code/Counter.tlv)

Here, we are introduced to a new operation ```>>?```. It is ahead of operator which will provide the value of that signal some clock cycles prior.

Below is the snippet for a free runnning up counter implemented in TL-Verilog on the maker chip platform.

We have a reset signal which will reset the output to 0 when it is pulled high.

```
$num[15:0] = *reset ? 0             // 0 if reset
                    : >>1$num + 1;  // otherwise add previous and 1
```

Below screenshot shows the implementation of the above counter logic on makerchip platform. We can also observe and verify the working of the logic using the generated waveform.

<img src="images/Lab6/seq_ckt.png" alt="Makerchip_Seq_Ckt" width="800"/><br>

### [Pipelined Logic](tl_verilog_code/Pipeline_Calc.tlv)

Below code snippet shows a Calculator logic implemented using TL-Verilog. It follows a pipelined design so that the circuit can be operated at higher clock frequencies.

The multiplexer to select the operation is shifted to the next clock cycle so that the calculator logic can operate at higher frequencies.

```
|calc
      @1
         $reset = *reset;
   
         $val1[31:0] = >>2$out[31:0];
         $val2[31:0] = $rand2[3:0];
         $sel[1:0] = $rand3[1:0];
   
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
            
         $count = $reset ? 0 : >>1$count + 1;
         
      @2
         $valid = !$count;
         $calc_reset = $reset | $valid;
         $out[31:0] = $calc_reset ? 32'b0
                                  : ($sel[1] ? ($sel[0] ? $quot[31:0] 
                                                        : $prod[31:0])
                                             : ($sel[0] ? $diff[31:0] 
                                                        : $sum[31:0]));
```

Below screenshot shows the implementation of above logic in MakerChip platform.

<img src="images/Lab6/pipeline_logic.png" alt="Makerchip_Pipeline_Ckt" width="800"/><br>

### [Validity](tl_verilog_code/Validity_Calculator.tlv)

Validity in TL-verilog means signal indicates validity of transaction and described as "when" scope else it will work as don't care. Denoted as ```?$valid```. Validity provides easier debug, cleaner design, better error checking, automated clock gating.

Below code snippet is a logic for 2-cycle calculator with validity,

```
|calc
      @0
         $reset = *reset;
      @1
         $valid = $reset ? 0 : >>1$valid + 1;
         $valid_or_reset = $valid || $reset; 
   
      ?$valid_or_reset
         @1   
            $val1[31:0] = >>2$out[31:0];
            $val2[31:0] = $rand2[3:0];
            $sel[1:0] = $rand3[1:0];
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
            $count = $reset ? 0 : >>1$count + 1;
         
         @2
            $out[31:0] = $reset ? 32'b0
                                : ($sel[1] ? ($sel[0] ? $quot[31:0] 
                                                      : $prod[31:0])
                                           : ($sel[0] ? $diff[31:0] 
                                                      : $sum[31:0]));
```

Below screenshot depicts the implementation of the above logic in MakerChip platform.

<img src="images/Lab6/validity_calculator.png" alt="Makerchip_Validity_Calc" width="800"/><br>

### [2-Cycle Validity Calculator with Memory](tl_verilog_code/Memory_Calculator.tlv)

Below is the code snippet for the calculator with memory,

<details>
<summary>2-Cycle Calculator with Memory</summary>
<pre>
|calc
      @0
         $reset = *reset;
      @1
         $valid = $reset ? 0 : >>1$valid+1;
         $valid_or_reset = $valid || $reset; 
   
      ?$valid_or_reset
         @1   
            $val1[31:0] = >>2$out[31:0];
            $val2[31:0] = $rand2[3:0];
            $sel[2:0] = $rand3[2:0];
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];  
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
         
         @2
            $mem[31:0] = $reset ? '0 : ($sel == 3'd5) ? >>2$out[31:0]
                                                      : >>2$mem[31:0];
            $recall[31:0] = >>2$mem[31:0];
            
            $out[31:0] = $reset ? '0 : ($sel == 3'd0) ? $sum[31:0]
                                     : ($sel == 3'd1) ? $diff[31:0]
                                     : ($sel == 3'd2) ? $prod[31:0]
                                     : ($sel == 3'd3) ? $quot[31:0]
                                     : ($sel == 3'd4) ? $recall[31:0]
                                     : '0;
</pre>
</details>
<br>
In the below screenshot, we can see the implementation of our code on the MakerChip platform,

<img src="images/Lab6/memory_calculator.png" alt="Makerchip_Validity_Memory_Calc" width="800"/><br>

</details>

---

<a name="Lab7"></a>

<details>
<summary>
Lab 7: A basic micro-architecture for RISC-V CPU
</summary>

### [Fetch](tl_verilog_code/fetch.tlv)

In the fetch stage, the CPU will fetch the next instruction to be executed from the instruction memory. 

The address from where the instruction will be fetched is provided by the program counter(PC).

Below code represents the logic to implement a program counter(PC) and how to fetch an instruction from the instruction memory.

```
|cpu
      @0
         $reset = *reset;
         
         $pc[31:0] = $reset ? '0 : >>1$pc + 32'd4;
         
         $imem_rd_en = !$reset ? 1 : 0;
         $imem_rd_addr[31:0] = $pc[M4_IMEM_INDEX_CNT+1:2];

      @1
         $instr[31:0] = $imem_rd_data[31:0];
```

Here, if the reset signal is high, then the program counter will be reset to value 0, otherwise when the program counter will increment by 4 since the address of each instruction is 32 bits wide.

The PC value will be fed as an input to the instruction memory to fetch the instruction from that particular address location.

Below is the screenshot where we can observe the implementation of the **Fetch** logic in MakerChip platform.

<img src="images/Lab7/fetch.png" alt="Makerchip_Fetch" width="800"/><br>

### [Decode](tl_verilog_code/decode.tlv)

In decode stage, we try to get the various infomation about an instruction from the fetch stage instruction read output.

The information what we try to decode is which instruction set it belongs to, what is the immediate value if it is present, the register values etc.

Below code snippet shows the logic used for the decode stage,

<details>
<summary>Decode Logic</summary>
<pre>
$instr[31:0] = $imem_rd_data[31:0];
         
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==  5'b11001;
         
         $is_r_instr = $instr[6:2] ==  5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==  5'b10100;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $is_b_instr = $instr[6:2] ==  5'b11000;
         
         $is_j_instr = $instr[6:2] ==  5'b11011;
         
         $is_u_instr = $instr[6:2] ==?  5'b0x101;
         
         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0}:
                      $is_u_instr ? {$instr[31], $instr[30:20], $instr[19:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                      32'b0;
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr;
         $rs1_valid = $is_r_instr || $is_s_instr || $is_i_instr || $is_b_instr;
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         $funct7_valid = $is_r_instr;
         
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
         
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
         
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
         
         $opcode[6:0] = $instr[6:0];
         
         $dec_bits[10:0] = {$funct7[5],$funct3,$opcode};
         
         $is_beq  = $dec_bits ==? 11'bx0001100011;
         $is_bne  = $dec_bits ==? 11'bx0011100011;
         $is_blt  = $dec_bits ==? 11'bx1001100011;
         $is_bge  = $dec_bits ==? 11'bx1011100011;
         $is_bltu = $dec_bits ==? 11'bx1101100011;
         $is_bgeu = $dec_bits ==? 11'bx1111100011;
         $is_addi = $dec_bits ==? 11'bx0000010011;
         $is_add  = $dec_bits ==  11'b00000110011;
</pre>
</details>

<br>
Below code shows the implementation of decode stage in the MakerChip platform,

<img src="images/Lab7/decode.png" alt="Makerchip_Decode" width="800"/><br>

### [Register Read and Write](tl_verilog_code/reg_file_read_write.tlv)

Here the Register file is having 2 read line, 1 write line means 2 read and 1 write operation can happen simultanously.

Inputs:
  * Read_Enable   - Enable signal to perform read operation
  * Read_Address1 - Address1 from where data has to be read 
  * Read_Address2 - Address2 from where data has to be read 
  * Write_Enable  - Enable signal to perform write operation
  * Write_Address - Address where data has to be written
  * Write_Data    - Data to be written at Write_Address

Outputs:
  * Read_Data1    - Data from Read_Address1
  * Read_Data2    - Data from Read_Address2

Below snippet shows the logic for Register read and write functionality.

<details>
<summary>Register File Read and Write Logic</summary>
<pre>
// Register File Read Logic
         
         ?$rs1_valid
            $rf_rd_en1 = $rs1_valid;
            $rf_rd_index1[4:0] = $rs1[4:0];
         
         ?$rs2_valid
            $rf_rd_en2 = $rs2_valid;
            $rf_rd_index2[4:0] = $rs2[4:0];
         
         $src1_value[31:0] = $rf_rd_data1[31:0];
         $src2_value[31:0] = $rf_rd_data2[31:0];
         
         //ALU
         
         $result[31:0] = $is_addi ? $src1_value + $imm :
                         $is_add  ? $src1_value + $src2_value :
                         32'bx;
         
         // Register File Write
         $rf_wr_en = ($rd == 5'b0) ? 1'b0 : $rd_valid;
         
         ?$rd_valid
            $rf_wr_index[4:0] = $rd[4:0];
         
         $rf_wr_data[31:0] = $result[31:0];
</pre>
</details>
<br>
Here, an ALU has also been designed with initially two operations, i.e, ADD and ADDI.

Below snippet shows the implementation of the above logic in the MakerChip platform,

<img src="images/Lab7/RF_Read_Write.png" alt="Makerchip_RF_Read_Write" width="800"/><br>

### [Conditional/Branch Logic](tl_verilog_code/Branch.tlv)

Here, we are calculating the program counter value for a branch instruction, by adding the immediate value to the current program counter. This branch program counter value is fed into the instruction fetch stage incase it is a branch instruction.

Below snippet shows the logic for the Branch Logic,

<details>
<summary>
Branch Logic
</summary>
<pre>
//Branch Instructions
         $taken_br = $is_beq ? ($src1_value == $src2_value) :
                     $is_bne ? ($src1_value != $src2_value) :
                     $is_blt ? (($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31])) :
                     $is_bge ? (($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31])) :
                     $is_bltu ? ($src1_value < $src2_value) :
                     $is_bgeu ? ($src1_value >= $src2_value) : 1'b0;
         
         $br_tgt_pc[31:0] = $pc + $imm;
</pre>
</details>
<br>

Below screenshot we can see the implementation of the branch logic in MakerChip platform,

<img src="images/Lab7/Branch.png" alt="Makerchip_Branch" width="800"/><br>

---
</details>

---

<a name="Lab8"></a>

<details>
<summary>
Lab 8: 3-Cycle Pipelined RISC-V CPU
</summary>

Here, we have implemented a 3-cycle RISC-V CPU by distributing the single cycle architecture into multiple cycle architecture. Also, all the possible pipelining hazards have been taken care of.

### [Complete Pipelined CPU](tl_verilog_code/Pipelined_CPU.tlv)

In the below screenshot, we can observe the output of the sum 1 to 9 program as register r10 = 45.

<img src="images/Lab8/Pipeline_viz.png" alt="Makerchip_Pipeline_Viz" width="800"/><br>

Here, it can be observed that the CPU took 56 cycles to execute the program to calculate sum of numbers from 1 to 9.

<img src="images/Lab8/Pipeline_Log.png" alt="Makerchip_Pipeline_Log" width="800"/><br>


### [Load and Store Operations](tl_verilog_code/Load_Store_Pipeline_CPU.tlv)

Inputs:
  * Read_Enable - Enable signal to perform read operation from the memory
  * Write_Enable - Enable signal to perform write operation to the memory
  * Address - Address specified whether to read/write from
  * Write_Data - Data to be written on Address (Store)

Output: 
  * Read_Data - Data to be read from Address (Load)

Added test case to check functionality of load/store.
Stored the summation of 1 to 9 on address 4 of Data Memory and loaded value from Data Memory to r15 register.

Below screenshot shows the output of the load and store operations testcase implemented on MakerChip platform,

<img src="images/Lab8/lw_sw_operation.png" alt="Makerchip_Pipeline_Load_Store" width="800"/><br>

### [Final Complete RISC-V CPU](tl_verilog_code/Final_CPU.tlv)

Added support for the jump instructions and added almost all the ALU operations support.

Below screenshots shows the final implementation and simulations on MakerChip Platform.

<img src="images/Lab8/Final_Clk.png" alt="Makerchip_Final_Clock_Signal" width="800"/><br>

The above image shows the clock signal of our RISC-V CPU.

<img src="images/Lab8/Final_Reset.png" alt="Makerchip_Final_Reset_Signal" width="800"/><br>

The above image shows the reset signal of our RISC-V CPU.

<img src="images/Lab8/Final_Reg_Val.png" alt="Makerchip_Final_Reg_Signal" width="800"/><br>

In the above screenshot, we can observe the gradual addition of the sum from 1 to 9 being accumulated in the R14 register. The entire program takes 58 cycles to complete including the load and store operations.

</details>

---

<a name="Lab9"></a>

<details>
<summary>
Lab 9: Conversion of RISC-V CPU tlv code to verilog code
</summary>

In this lab, we will convert our tlv code to verilog code using the python's sandpiper-saas library.

Later, post conversion to verilog code, we will also be writing a verilog testbench and compare the waveforms obtained from MakerChip platform and the verilog code output.

Following are the necessary steps to convert the tlv code to verilog code,

### Installation of necessary tools

To install the necessary tools for this activity, execute the following command in the Linux terminal window.

```
sudo apt install make python python3 python3-pip git iverilog gtkwave python3-venv
```

### Conversion to verilog code

We will convert our tlv code to verilog format by creating a python virtual environment.

Here, python's virtual environment is used so that when we add additional python libraries, it doesn't affects anything in the entire system.

To create a virtual environment using python, use the following command

```
python -m venv .venv 
```

Use the following command to download the python's **sandpiper-saas** module.

```
pip3 install sandpiper-saas
```

We will use the sandpiper-saas library to convert our tlv code to verilog code. Use the below command for conversion to verilog code.

```
sandpiper-saas -i ./tlv_code/Final_CPU.tlv -o RV_CPU.v --bestsv --noline -p verilog --outdir ./src/module/
```

Verify that the conversion is correct and we don't have any errros.

### Creation of testbench and simulation of the verilog code.

Now, to simulate our verilog code of the RISC-V CPU, we need to write a testbench.

Once the testbench is ready, use the following command to compile the verilog code.

```
iverilog -o output/RV_CPU.out src/module/RV_CPU_tb.v -I src/include -I src/module
```

Once the verilog code is compiled successfully, execute the out file to obtain the .vcd file to observe the waveforms using gtkwave

```
cd output
./RV_CPU.out
gtkwave RV_CPU_tb.vcd
```

### Simulation Results

In this section, we can observe the clk, reset and the 10-bit out signals. The out signal contains the sum of numbers from 1 to 9.

Following are the waveforms from the Makerchip Platform for the tlv code,

<img src="images/Lab8/Final_Clk.png" alt="Makerchip_Final_Clock_Signal" width="800"/><br>

<img src="images/Lab8/Final_Reset.png" alt="Makerchip_Final_Reset_Signal" width="800"/><br>

<img src="images/Lab8/Final_Reg_Val.png" alt="Makerchip_Final_Reg_Signal" width="800"/><br>

Following is the waveform obtained after simulation of our generated verilog code,

<img src="images/Lab9/gtkwave_output.png" alt="Verilog_Waveform" width="800"/><br>

### Results

If we compare the above waveforms, we can see that the result is same for the simulation of tlv code with that of simulation of the converted verilog code.

**clk_ayu** signal represents the clk signal used by our RV-CPU.

**reset** signal is used to reset the CPU whenever required.

**out** is the 10-bit output signal where we can observe the sum of numbers from 1 to 9 happening gradually.

</details>

---

<a name="Lab10"></a>

<details>
<summary>
Lab 10: Tools Installation and BabySoC Simulation
</summary>

### Tools Installation

Commands to install Yosys in Linux:
```
    $ git clone https://github.com/YosysHQ/yosys.git
    $ cd yosys
    $ sudo apt install make (If make is not installed) 
    $ sudo apt-get install build-essential clang bison flex \
        libreadline-dev gawk tcl-dev libffi-dev git \
        graphviz xdot pkg-config python3 libboost-system-dev \
        libboost-python-dev libboost-filesystem-dev zlib1g-dev
    $ make config-gcc
    $ make 
    $ sudo make install
```

To verify the installation of yosys, type yosys in terminal window
<img src="images/Lab10/yosys.png" alt="Yosys" width="800"/><br>

Commands to install iverilog in Linux:

```
    sudo apt-get install iverilog
```

Below screenshot verifies the installation of iverilog in the system,


<img src="images/Lab10/iverilog.png" alt="iverilog" width="800"/><br>

Commands to install gtkwave in Linux:

```
    sudo apt update
    sudo apt install gtkwave
```

Below screenshot verifies the installation of gtkwave in the system,


<img src="images/Lab10/gtkwave.png" alt="gtkwave" width="800"/><br>

For installation of Open STA, please follow the build instructions on the below link,

https://github.com/The-OpenROAD-Project/OpenSTA

---

### BabySoC Simulation

Here, it is a quite complex task to develop and simulate the entire micro-architecture of a RISC-V CPU.

Therefore, we will only consider to add only two IPs for now, that is **PLL** and **DAC** .

---
#### **Phase-Locked-Loop (PLL)**

A Phase-Locked Loop (PLL) is an electronic circuit that synchronizes an output signal's phase and frequency with a reference signal.  It typically consists of three main components:

1.    Phase Detector: Compares the phase of the reference signal with the output signal and generates an error signal based on the difference.

2.    Loop Filter: Processes the error signal to smooth it out, reducing noise and improving stability.
    
3.    Voltage-Controlled Oscillator (VCO): Adjusts its output frequency based on the filtered error signal to minimize the phase difference.

The PLL is widely used in applications such as clock generation, frequency synthesis, and data recovery in communication systems.

#### **Digital-to-Analog Converter (DAC)**

A Digital-to-Analog Converter (DAC) is an electronic device that converts digital signals (typically binary) into analog signals (such as voltage or current). 

This conversion is crucial in systems where digital data needs to be interpreted by analog devices or for output to be perceived by humans, like in audio and video equipment. 

DACs are commonly used in applications like audio playback, video display, and signal processing.

---


#### Files required for BabySoC simulation


* src/module - contains all RTL files and testbench.v used for simulating our BabySoC design.
* src/include - contains RTL files used in `include define in  main RTL files in src/module.

**Note** : These above files except the RV_CPU.v have been taken from the below reference repo,
https://github.com/Subhasis-Sahu/BabySoC_Simulation

#### To run the functional simulation,

* ` iverilog -o output/RV_CPU.out src/module/testbench.v -I src/include -I src/module `
* ` ./RV_CPU.out `
* ` gtkwave dump.out `

In the below screenshot, the output of the sum 1 to 9 can be observed after simulation,

<img src="images/Lab10/tb_output.png" alt="gtkwave" width="800"/><br>


* **REF** is the input clk reference signal to the PLL module.
* **CLK** is the output clk signal from the PLL module.
* **clk_ayu** is the clock used by the RISC-V CPU for the operations.
* **reset** is the reset signal for the RISC-V CPU.
* **out** is the ouput signal from the RISC-V CPU. Here we can observe the sum value from 1 to 9 over multiple clock cycles.
* **OUT** is the DAC output signal.

Below is the zoomed out version of the same above waveform screenshot,

<img src="images/Lab10/tb_output_full.png" alt="gtkwave_zo" width="800"/><br>

</details>

---


<a name="Lab11"></a>

<details>
<summary>
Lab 11: RTL Design using Verilog and SKY130 Technology
</summary>


## Introduction to iverilog and gtkwave

Below is the command to simulate the RTL design for a 2 input MUX along with it's testbench using iverilog,

<img src="images/Lab11/11_1.png" alt="iverilog" width="800"/><br>

Once, the compilation happens, an executable is generated. This executable can be run to observe the output with variations in input signal specified by the testbench.

<img src="images/Lab11/11_2.png" alt="a_out_execute" width="800"/><br>

To observe the output, we use the gtkwave to open the generated vcd file,

<img src="images/Lab11/11_3.png" alt="gtkwave" width="800"/><br>

<a name="Lab11_1"></a>

## Introduction to Synthesis and Yosys

### What is Synthesis ?

The process of conversion of an RTL behavioural design into a gate level netlist is known as Synthesis.

### What is Synthesizer?

The tool used to convert the RTL design to netlist is known as Synthesizer. In our course, **Yosys** is the Synthesizer.

Below image briefly depicts the flow of Synthesis,

<img src="images/Lab11/11_4.png" alt="Synthesis_Flow" width="800"/><br>

The **.lib** or the **Front End Library** contains a collection of logical modules. It includes basic gates such as AND, OR, NOT etc. It can have gates with different number of inputs, having different speeds.

To satisfy the requirements for Setup and Hold time, we require gate with different speeds.

Often we need to guide the Synthesizer to select the appropriate gate sizes for the implementation of the logic.

If we use more faster cells, then the circuit may violate the hold time requirements and the circuit may be bad in terms of Power and Area.

If more slower cells are used, then the designed circuit may become sluggish and it may not meet the design requirements.

This guidance is often provided to the Synthesizer as a Constraint.

<a name="Lab11_2"></a>

## RTL to netlist conversion using Yosys

First, we need to read the SKY130 library file in yosys. Below is the command used,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```

To read the verilog file into Yosys, use the below command. Make sure that there is no error once the Verilog file is loaded.

```
read_verilog verilog_files/good_mux.v
```

Below is the command to start the Synthesis project,

```
synth -top good_mux
```

Following is the result, after the process of Synthesis,

<img src="images/Lab11/11_5.png" alt="Synthesis_Results" width="800"/><br>

To generate the netlist, following command needs to executed

```
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```


Below is the output for the above command to generate the netlist,

<img src="images/Lab11/11_6.png" alt="Netlist" width="800"/><br>

To observe the implementation in a graphical manner, run the following command,

```
show
```

Below the visual representation of the netlist,

<img src="images/Lab11/11_7.png" alt="Netlist_Graph" width="800"/><br>

To dump the verilog code for the netlist with minimal information, use the command below

```
write_verilog -noattr verilog_files/good_mux_netlist.v
```

Below is the generated netlist for a 2:1 MUX,

<details>
<summary>
2:1 MUX netlist
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module good_mux(i0, i1, sel, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input i0;
  wire i0;
  input i1;
  wire i1;
  input sel;
  wire sel;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _4_ (
    .A0(_0_),
    .A1(_1_),
    .S(_2_),
    .X(_3_)
  );
  assign _0_ = i0;
  assign _1_ = i1;
  assign _2_ = sel;
  assign y = _3_;
endmodule
```

</details>

<a name="Lab11_3"></a>

## Introduction to SKY130 library file

The name of the library file is **sky130_fd_sc_hd__tt_025C_1v80**

* It is a 130 nm library
* **tt** stands for typical
* **025C** denotes the temperature
* **1v8** indicates the voltage

Any library would contain information about,

* **Process**: It defines characteristics of the chip to be designed using the particular library due to variations in fabrication
* **Voltage**: This defines the behaviour of the Sillicon with respect to variations in voltage.
* **Temperature**: Defines the optimal temperature at which the library is defined.


Further, if we explore the library we can observe the following information,

* The technology used in this library is **cmos**
* Delay model is **table_lookup**.
* Time unit is **nano Seconds**
* Current unit is **milli Amperes**
* Power unit is **milli Watts**
* Resistance unit is **KOhms**
* Capacitance unit is **picoFarads**
* Operating Conditions is mentioned in terms of **PVT** as **tt_025C_1v80**

### Standard Cell Information

We know that a library file contains a collection of standard cells.

Below screenshot shows the information about one of the cells present in the library files,

<img src="images/Lab11/11_8.png" alt="Standard_Cell" width="800"/><br>

The behaviour of the particular cell can be described as follows,

```
X = ((A1 & A2) | B1 | C1 | D1)
```

So, a total of 32 input combinations possible. So the cell information will contain the details about the Power and Delay for all such 32 input combinations.

Later, if we inspect the information about the cell, we can further information,

* Details about Area
* Details abput Power Pins
* Details of Input pins like the Capacitance, Power, Transition information etc.

### Comparison of AND2_0 gate and AND2_2 gate variants

Below image shows a side by side comparison of the AND2_0 gate and AND2_2 gate variants,

<img src="images/Lab11/11_9.png" alt="2ANDvs3AND" width="800"/><br>

Here, if we look closely at the **Area** information, we can observe AND2_2 has more area than AND2_0, which means that wider transistors are used to implement AND2_2.

Also, if we look at the power information, we can see that AND2_2 uses more power as it is using wider transistors.

### Lookup table Delay Model

The delay model in such files typically relies on lookup tables (LUTs) based on different signal conditions. The table_lookup is used to model delays based on input conditions such as:

* Input Slew (transition time at the input)
* Output Load (the capacitance at the output pin)
* Voltage and Temperature (for different operating conditions)

The idea is that the delay (or transition time) is not fixed, but varies according to these input conditions. The delay is pre-characterized for different combinations of slew rates and load capacitances, and these values are stored in a multi-dimensional table (hence the lookup). When the timing engine calculates delays, it uses interpolation to derive the delay from these tables.

<a name="Lab11_4"></a>

## Hierarchial vs Flat Synthesis

### Hierarchial Synthesis

We will synthesize the **multiple_mocdules.v** file.

<details>
<summary>
multiple_modules.v
</summary>

```
module sub_module2 (input a, input b, output y);
	assign y = a | b;
endmodule

module sub_module1 (input a, input b, output y);
	assign y = a&b;
endmodule


module multiple_modules (input a, input b, input c , output y);
	wire net1;
	sub_module1 u1(.a(a),.b(b),.y(net1));  //net1 = a&b
	sub_module2 u2(.a(net1),.b(c),.y(y));  //y = net1|c ,ie y = a&b + c;
endmodule
```

</details>

We will try to synthesize it using the following command,

```
synth -top multiple_modules
```

Below is the synthesis output report,

<img src="images/Lab11/11_10.png" alt="Synthesis_Output" width="800"/><br>

We see that 1 AND and 1 OR gate cell will be used to design the circuit.

Let's check the design if we run the following command to show the design,

```
show multiple_modules
```

<img src="images/Lab11/11_11.png" alt="Synthesis_Output" width="800"/><br>

Here, we can observe that we don't see the AND and OR gate which we expected. Instead we see the instances of sub_module1 and sub_module2.

This is known as **Hierarchial Synthesis** since the hierachy of the design getting preserved.


Below is how the netlist would look, if the following command is executed,

```
write_verilog -noattr verilog_files/multiple_modules_hier.v
```

<details>
<summary>
multiple_modules Hierarchial Synthesis Netlist
</summary>

/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module multiple_modules(a, b, c, y);
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  wire net1;
  output y;
  wire y;
  sub_module1 u1 (
    .a(a),
    .b(b),
    .y(net1)
  );
  sub_module2 u2 (
    .a(net1),
    .b(c),
    .y(y)
  );
endmodule

module sub_module1(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__and2_0 _3_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  assign _1_ = b;
  assign _0_ = a;
  assign y = _2_;
endmodule

module sub_module2(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__or2_0 _3_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  assign _1_ = b;
  assign _0_ = a;
  assign y = _2_;
endmodule

</details>

<br>
From the netlist, we can observe as well that the hierarchy is getting preserved if we use the **synth -top** command during Synthesis.

### Flat Synthesis

We will now use the following command to let go of the hierarchy,

```
flatten
```

Below is the graphical representation of the design after running the **flatten** command,

<img src="images/Lab11/11_12.png" alt="Synthesis_Output" width="800"/><br>

We can now observe that the design is now implemented using basic gates, it is no longer maintaining the hierarchy.

Below is the generated netlist post running the **flatten** command,

<details>
<summary>
multiple_modules Flat Synthesis Netlist
</summary>

/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module multiple_modules(a, b, c, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  wire _5_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  wire net1;
  wire \u1.a ;
  wire \u1.b ;
  wire \u1.y ;
  wire \u2.a ;
  wire \u2.b ;
  wire \u2.y ;
  output y;
  wire y;
  sky130_fd_sc_hd__and2_0 _6_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  sky130_fd_sc_hd__or2_0 _7_ (
    .A(_4_),
    .B(_3_),
    .X(_5_)
  );
  assign _4_ = \u2.b ;
  assign _3_ = \u2.a ;
  assign \u2.y  = _5_;
  assign \u2.a  = net1;
  assign \u2.b  = c;
  assign y = \u2.y ;
  assign _1_ = \u1.b ;
  assign _0_ = \u1.a ;
  assign \u1.y  = _2_;
  assign \u1.a  = a;
  assign \u1.b  = b;
  assign net1 = \u1.y ;
endmodule

</details>

<br>
From the netlist, we can see that there is direct instantiation of the AND and OR gates. The hierarchy is no longer preserved.

### When do we do Sub-Module level Synthesis?

* When there is repetition in the instantiation of the same sub-module many times, then we can synthesis that particular sub-module once and then replicate it elsewhere.

* If the design is quite massive, then we use the divide and conquer approach. We synthesis by passing sub-modules one at a time in series since running the synthesis on the whole big design may not be a good idea since the tool may not perform very well.

<a name="Lab11_5"></a>

## Flop Coding Styles and Optimizations

### D Flip-flop with Asynchronous Reset

Let's simulate the D Flip-flop with Asynchronous Reset in iverilog.

To compile the verilog code, following is the command

```
iverilog verilog_files/dff_asyncres.v verilog_files/tb_dff_asyncres.v
```

To execute the generated out file, following is the command,
```
./a.out
```

Finally, to observe the waveform with variations in inputs defined in the inputs, following is the command,
```
gtkwave tb_dff_asyncres.vcd
```

Below is how the waveform looks for a D flip-flop with asynchronous reset

<img src="images/Lab11/11_13.png" alt="DFF_Async_Reset" width="800"/><br>

We can clearly see that as soon as reset signal goes from high to low, the output q starts following input d.

#### Synthesis using Yosys

To synthesize the D flip-flop, use the following command, 

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog verilog_files/dff_asyncres.v
synth -top dff_asyncres
dfflibmap -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

Below is the graphical representation of the synthesized design,
<img src="images/Lab11/11_16.png" alt="DFF_Async_Reset" width="800"/><br>

### D Flip-flop with Asynchronous Set

To compile the verilog code, following is the command

```
iverilog verilog_files/dff_async_set.v verilog_files/tb_dff_async_set.v 
```

To execute the generated out file, following is the command,
```
./a.out
```

Finally, to observe the waveform with variations in inputs defined in the inputs, following is the command,
```
gtkwave tb_dff_async_set.vcd
```

Below is how the waveform looks for a D flip-flop with asynchronous set

<img src="images/Lab11/11_14.png" alt="DFF_Async_Set" width="800"/><br>

We can clearly see that as soon as set signal goes from low to high, the output q is set to 1 irrespective of the clock's active edge.

#### Synthesis using Yosys

Below is the graphical representation of the synthesized design,
<img src="images/Lab11/11_17.png" alt="DFF_Async_Reset" width="800"/><br>

### D Flip-flop with Synchronous Reset

To compile the verilog code, following is the command

```
iverilog verilog_files/dff_syncres.v verilog_files/tb_dff_syncres.v
```

To execute the generated out file, following is the command,
```
./a.out
```

Finally, to observe the waveform with variations in inputs defined in the inputs, following is the command,
```
gtkwave tb_dff_syncres.vcd
```

Below is how the waveform looks for a D flip-flop with Synchronous Reset

<img src="images/Lab11/11_15.png" alt="DFF_Sync_Reset" width="800"/><br>

We can clearly see that as soon as reset signal goes from low to high, the output q is set to 0 at the next active clock edge.

#### Synthesis using Yosys

Below is the graphical representation of the synthesized design,
<img src="images/Lab11/11_18.png" alt="DFF_Async_Reset" width="800"/><br>

### Optimizations for mult_2.v and mult_8.v

#### mult2.v

If we compare the input and output combinations, we observe that we don't any sort of extra cells. We just need to assign one more wire to obtain the output.

We can also observe that there are no cells being used,
<img src="images/Lab11/11_19.png" alt="DFF_Async_Reset" width="800"/><br>

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_20.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
Verilog Netlist for mult2 Synthesis
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module mul2(a, y);
  input [2:0] a;
  wire [2:0] a;
  output [3:0] y;
  wire [3:0] y;
  assign y = { a, 1'h0 };
endmodule
```

</details>

#### mult8.v

If we compare the input and output combinations, we observe that we don't any sort of extra cells.

For the output, only the 3 bit input is getting copied two times and output is of 6 bits.

We can also observe that there are no cells being used,
<img src="images/Lab11/11_21.png" alt="DFF_Async_Reset" width="800"/><br>

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_22.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
Verilog Netlist for mult8 Synthesis
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module mult8(a, y);
  input [2:0] a;
  wire [2:0] a;
  output [5:0] y;
  wire [5:0] y;
  assign y = { a, a };
endmodule
```
</details>

<a name="Lab11_6"></a>

## Combinational and Sequential Optimizations


### Combinational Optimizations

#### Why Combinational Optimization?

* To squeeze the logic to get the most optimized design to achieve area and power savings

#### Techniques for optimization

* Constant Propagation
* Boolean Logic Optimization

#### opt_check.v

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_59.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_60.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_61.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
opt_check.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module opt_check(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__and2_0 _3_ (
    .A(_1_),
    .B(_0_),
    .X(_2_)
  );
  assign _1_ = b;
  assign _0_ = a;
  assign y = _2_;
endmodule
```
</details>

#### opt_check2.v

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_62.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_63.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_64.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
opt_check2.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module opt_check2(a, b, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  output y;
  wire y;
  sky130_fd_sc_hd__or2_0 _3_ (
    .A(_0_),
    .B(_1_),
    .X(_2_)
  );
  assign _0_ = a;
  assign _1_ = b;
  assign y = _2_;
endmodule
```
</details>

#### opt_check3.v

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_65.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_66.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_67.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
opt_check3.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module opt_check3(a, b, c, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  output y;
  wire y;
  sky130_fd_sc_hd__and3_1 _5_ (
    .A(_2_),
    .B(_3_),
    .C(_1_),
    .X(_4_)
  );
  assign _2_ = b;
  assign _3_ = c;
  assign _1_ = a;
  assign y = _4_;
endmodule
```
</details>

#### opt_check4.v

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_68.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_69.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
opt_check4.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module opt_check4(a, b, c, y);
  wire _0_;
  wire _1_;
  wire _2_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  output y;
  wire y;
  sky130_fd_sc_hd__xnor2_1 _3_ (
    .A(_0_),
    .B(_1_),
    .Y(_2_)
  );
  assign _0_ = a;
  assign _1_ = c;
  assign y = _2_;
endmodule
```
</details>

### Sequential Optimizations

#### dff_const1.v

To verify the working in iverilog and gtkwave, use the following commands,

```
iverilog verilog_files/dff_const1.v verilog_files/tb_dff_const1.v
./a.out
gtkwave tb_dff_const1.vcd
```
Below is the screenshot for the gtkwave window,

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_23.png" alt="DFF_Async_Reset" width="800"/><br>

Use the following commands to run the synthesis and get the netlist for the RTL design,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/dff_const1.v
synth -top dff_const1
dfflib -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr verilog_files/dff_const1_netlist.v
```

Post synthesis, following report shows which cells are being used to implement the RTL design,
Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_24.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_25.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the generated netlist post successful synthesis,

<details>
<summary>
dff_const1_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module dff_const1(clk, reset, q);
  wire _0_;
  wire _1_;
  wire _2_;
  input clk;
  wire clk;
  output q;
  wire q;
  input reset;
  wire reset;
  sky130_fd_sc_hd__clkinv_1 _3_ (
    .A(_1_),
    .Y(_0_)
  );
  sky130_fd_sc_hd__dfrtp_1 _4_ (
    .CLK(clk),
    .D(1'h1),
    .Q(q),
    .RESET_B(_2_)
  );
  assign _1_ = reset;
  assign _2_ = _0_;
endmodule
```

</details>


#### dff_const2.v

To verify the working in iverilog and gtkwave, use the following commands,

```
iverilog verilog_files/dff_const2.v verilog_files/tb_dff_const2.v
./a.out
gtkwave tb_dff_const2.vcd
```
Below is the screenshot for the gtkwave window,

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_26.png" alt="DFF_Async_Reset" width="800"/><br>

Use the following commands to run the synthesis and get the netlist for the RTL design,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/dff_const2.v
synth -top dff_const2
dfflib -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr verilog_files/dff_const2_netlist.v
```

Post synthesis, following report shows which cells are being used to implement the RTL design,
Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_27.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_28.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the generated netlist post successful synthesis,

<details>
<summary>
dff_const2_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module dff_const2(clk, reset, q);
  input clk;
  wire clk;
  output q;
  wire q;
  input reset;
  wire reset;
  assign q = 1'h1;
endmodule
```

</details>

#### dff_const3.v

To verify the working in iverilog and gtkwave, use the following commands,

```
iverilog verilog_files/dff_const3.v verilog_files/tb_dff_const3.v
./a.out
gtkwave tb_dff_const3.vcd
```
Below is the screenshot for the gtkwave window,

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_29.png" alt="DFF_Async_Reset" width="800"/><br>

Use the following commands to run the synthesis and get the netlist for the RTL design,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/dff_const3.v
synth -top dff_const3
dfflib -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr verilog_files/dff_const3_netlist.v
```

Post synthesis, following report shows which cells are being used to implement the RTL design,
Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_30.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_31.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the generated netlist post successful synthesis,

<details>
<summary>
dff_const3_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module dff_const3(clk, reset, q);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input clk;
  wire clk;
  output q;
  wire q;
  wire q1;
  input reset;
  wire reset;
  sky130_fd_sc_hd__clkinv_1 _5_ (
    .A(_2_),
    .Y(_0_)
  );
  sky130_fd_sc_hd__clkinv_1 _6_ (
    .A(_2_),
    .Y(_1_)
  );
  sky130_fd_sc_hd__dfstp_2 _7_ (
    .CLK(clk),
    .D(q1),
    .Q(q),
    .SET_B(_3_)
  );
  sky130_fd_sc_hd__dfrtp_1 _8_ (
    .CLK(clk),
    .D(1'h1),
    .Q(q1),
    .RESET_B(_4_)
  );
  assign _2_ = reset;
  assign _3_ = _0_;
  assign _4_ = _1_;
endmodule

```

</details>



#### dff_const4.v

To verify the working in iverilog and gtkwave, use the following commands,

```
iverilog verilog_files/dff_const4.v verilog_files/tb_dff_const4.v
./a.out
gtkwave tb_dff_const4.vcd
```
Below is the screenshot for the gtkwave window,

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_32.png" alt="DFF_Async_Reset" width="800"/><br>

Use the following commands to run the synthesis and get the netlist for the RTL design,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/dff_const4.v
synth -top dff_const4
dfflib -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr verilog_files/dff_const4_netlist.v
```

Post synthesis, following report shows which cells are being used to implement the RTL design,
Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_33.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_34.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the generated netlist post successful synthesis,

<details>
<summary>
dff_const4_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module dff_const4(clk, reset, q);
  input clk;
  wire clk;
  output q;
  wire q;
  wire q1;
  input reset;
  wire reset;
  assign q = 1'h1;
  assign q1 = 1'h1;
endmodule
```

</details>

#### dff_const5.v

To verify the working in iverilog and gtkwave, use the following commands,

```
iverilog verilog_files/dff_const5.v verilog_files/tb_dff_const5.v
./a.out
gtkwave tb_dff_const5.vcd
```
Below is the screenshot for the gtkwave window,

Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_35.png" alt="DFF_Async_Reset" width="800"/><br>

Use the following commands to run the synthesis and get the netlist for the RTL design,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/dff_const5.v
synth -top dff_const5
dfflib -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -noattr verilog_files/dff_const5_netlist.v
```

Post synthesis, following report shows which cells are being used to implement the RTL design,
Following shows the graphical representation post synthesis,
<img src="images/Lab11/11_36.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_37.png" alt="DFF_Async_Reset" width="800"/><br>

Following is the generated netlist post successful synthesis,

<details>
<summary>
dff_const5_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module dff_const5(clk, reset, q);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input clk;
  wire clk;
  output q;
  wire q;
  wire q1;
  input reset;
  wire reset;
  sky130_fd_sc_hd__clkinv_1 _5_ (
    .A(_2_),
    .Y(_0_)
  );
  sky130_fd_sc_hd__clkinv_1 _6_ (
    .A(_2_),
    .Y(_1_)
  );
  sky130_fd_sc_hd__dfrtp_1 _7_ (
    .CLK(clk),
    .D(q1),
    .Q(q),
    .RESET_B(_3_)
  );
  sky130_fd_sc_hd__dfrtp_1 _8_ (
    .CLK(clk),
    .D(1'h1),
    .Q(q1),
    .RESET_B(_4_)
  );
  assign _2_ = reset;
  assign _3_ = _0_;
  assign _4_ = _1_;
endmodule
```

</details>

### Unused Output Optimizations

Unused Output Optimization involves strategies and techniques focused on minimizing or removing redundant or unnecessary outputs in processes, systems, or designs to improve efficiency and performance.

#### Synthesis of counter_opt.v

Below screenshot shows the synthesis report for the same,
<img src="images/Lab11/11_38.png" alt="DFF_Async_Reset" width="800"/><br>


Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_39.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
counter_opt_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module counter_opt(clk, reset, q);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire [2:0] _4_;
  wire _5_;
  input clk;
  wire clk;
  wire [2:0] count;
  output q;
  wire q;
  input reset;
  wire reset;
  sky130_fd_sc_hd__clkinv_1 _6_ (
    .A(_2_),
    .Y(_0_)
  );
  sky130_fd_sc_hd__clkinv_1 _7_ (
    .A(_3_),
    .Y(_1_)
  );
  sky130_fd_sc_hd__dfrtp_1 _8_ (
    .CLK(clk),
    .D(_4_[0]),
    .Q(count[0]),
    .RESET_B(_5_)
  );
  assign _4_[2:1] = count[2:1];
  assign q = count[0];
  assign _2_ = count[0];
  assign _4_[0] = _0_;
  assign _3_ = reset;
  assign _5_ = _1_;
endmodule
```

</details>


#### Synthesis of counter_opt2.v

Below screenshot shows the synthesis report for the same,
<img src="images/Lab11/11_40.png" alt="DFF_Async_Reset" width="800"/><br>


Below screenshot shows the graphical representation of the synthesized design,
<img src="images/Lab11/11_41.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
counter_opt2_netlist.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module counter_opt2(clk, reset, q);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire [2:0] _14_;
  wire [2:0] _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  input clk;
  wire clk;
  wire [2:0] count;
  output q;
  wire q;
  input reset;
  wire reset;
  sky130_fd_sc_hd__clkinv_1 _19_ (
    .A(_08_),
    .Y(_02_)
  );
  sky130_fd_sc_hd__clkinv_1 _20_ (
    .A(_13_),
    .Y(_05_)
  );
  sky130_fd_sc_hd__nor3b_1 _21_ (
    .A(_08_),
    .B(_09_),
    .C_N(_10_),
    .Y(_12_)
  );
  sky130_fd_sc_hd__nand2_1 _22_ (
    .A(_08_),
    .B(_09_),
    .Y(_11_)
  );
  sky130_fd_sc_hd__xor2_1 _23_ (
    .A(_08_),
    .B(_09_),
    .X(_03_)
  );
  sky130_fd_sc_hd__xnor2_1 _24_ (
    .A(_10_),
    .B(_11_),
    .Y(_04_)
  );
  sky130_fd_sc_hd__clkinv_1 _25_ (
    .A(_13_),
    .Y(_06_)
  );
  sky130_fd_sc_hd__clkinv_1 _26_ (
    .A(_13_),
    .Y(_07_)
  );
  sky130_fd_sc_hd__dfrtp_1 _27_ (
    .CLK(clk),
    .D(_14_[0]),
    .Q(count[0]),
    .RESET_B(_16_)
  );
  sky130_fd_sc_hd__dfrtp_1 _28_ (
    .CLK(clk),
    .D(_15_[1]),
    .Q(count[1]),
    .RESET_B(_17_)
  );
  sky130_fd_sc_hd__dfrtp_1 _29_ (
    .CLK(clk),
    .D(_15_[2]),
    .Q(count[2]),
    .RESET_B(_18_)
  );
  assign _15_[0] = _14_[0];
  assign _14_[2:1] = count[2:1];
  assign _08_ = count[0];
  assign _14_[0] = _02_;
  assign _09_ = count[1];
  assign _10_ = count[2];
  assign q = _12_;
  assign _15_[1] = _03_;
  assign _15_[2] = _04_;
  assign _13_ = reset;
  assign _16_ = _05_;
  assign _17_ = _06_;
  assign _18_ = _07_;
endmodule
```

</details>

<a name="Lab11_7"></a>

## GLS, Blocking v/s Non-Blocking and Synthesis-Simulation Mismatch

<img src="images/Lab11/11_42.png" alt="DFF_Async_Reset" width="800"/><br>

### What is GLS?

* GLS stands for Gate Level Synthesis
* Use the same testbench with the synthesized gate level verilog code as the DUT.

### Why GLS?

* To verify logical correctness of the design post synthesis
* To ensure that the timing constraints are met

### Reasons for Synthesis Simulation Mismatch

* Missing Sensitivity List
* Blocking vs Non-blocking Assignments
* Non-standard verilog coding


### Synthesis Simulation Mismatch

#### ternary_operator_mux.v

Below is the simulation of the behaviour design using iverilog and gtkwave,

<img src="images/Lab11/11_43.png" alt="DFF_Async_Reset" width="800"/><br>

Follow the below commands for Synthesis,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/ternary_operator_mux.v
synth -top ternary_operator_mux
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

Following is the post synthesis report for the same design,

<img src="images/Lab11/11_44.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,

<img src="images/Lab11/11_45.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
ternary_operator_mux.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module ternary_operator_mux(i0, i1, sel, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input i0;
  wire i0;
  input i1;
  wire i1;
  input sel;
  wire sel;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _4_ (
    .A0(_0_),
    .A1(_1_),
    .S(_2_),
    .X(_3_)
  );
  assign _0_ = i0;
  assign _1_ = i1;
  assign _2_ = sel;
  assign y = _3_;
endmodule
```

</details>

Below screenshot shows the simulation of the generated netlist with the same testbench,

<img src="images/Lab11/11_46.png" alt="DFF_Async_Reset" width="800"/><br>

#### good_mux.v

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_47.png" alt="DFF_Async_Reset" width="800"/><br>

Follow the below commands for Synthesis,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/good_mux.v
synth -top good_mux
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_48.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_49.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
good_mux.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module good_mux(i0, i1, sel, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input i0;
  wire i0;
  input i1;
  wire i1;
  input sel;
  wire sel;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _4_ (
    .A0(_0_),
    .A1(_1_),
    .S(_2_),
    .X(_3_)
  );
  assign _0_ = i0;
  assign _1_ = i1;
  assign _2_ = sel;
  assign y = _3_;
endmodule
```

</details>

Below screenshot shows the simulation of the generated netlist with the same testbench,

<img src="images/Lab11/11_50.png" alt="DFF_Async_Reset" width="800"/><br>

#### bad_mux.v

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_51.png" alt="DFF_Async_Reset" width="800"/><br>

Follow the below commands for Synthesis,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/bad_mux.v
synth -top bad_mux
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_52.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_53.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
bad_mux.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module bad_mux(i0, i1, sel, y);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input i0;
  wire i0;
  input i1;
  wire i1;
  input sel;
  wire sel;
  output y;
  wire y;
  sky130_fd_sc_hd__mux2_1 _4_ (
    .A0(_0_),
    .A1(_1_),
    .S(_2_),
    .X(_3_)
  );
  assign _0_ = i0;
  assign _1_ = i1;
  assign _2_ = sel;
  assign y = _3_;
endmodule
```

</details>

Below screenshot shows the simulation of the generated netlist with the same testbench,

<img src="images/Lab11/11_54.png" alt="DFF_Async_Reset" width="800"/><br>

### Simulation Mismatch for Blocking Statements

#### blocking_caveat.v

Follow the below commands to simulate the behavioural model using iverilog and gtkwave,

```
iverilog verilog_files/blocking_caveat.v verilog_files/tb_blocking_caveat.v
./a.out
gtkwave tb_blocking_caveat.vcd
```

Below is the simulation of the behaviour design using iverilog and gtkwave,
<img src="images/Lab11/11_55.png" alt="DFF_Async_Reset" width="800"/><br>

Follow the below commands for Synthesis,

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib 
read_verilog verilog_files/blocking_caveat.v
synth -top blocking_caveat
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

Following is the post synthesis report for the same design,
<img src="images/Lab11/11_56.png" alt="DFF_Async_Reset" width="800"/><br>

In the below screenshot, we can observe the graphical representation of the synthesized design,
<img src="images/Lab11/11_57.png" alt="DFF_Async_Reset" width="800"/><br>

<details>
<summary>
blocking_caveat.v
</summary>

```
/* Generated by Yosys 0.44+60 (git sha1 0fc5812dc, g++ 13.2.0-23ubuntu4 -fPIC -O3) */

module blocking_caveat(a, b, c, d);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input a;
  wire a;
  input b;
  wire b;
  input c;
  wire c;
  output d;
  wire d;
  sky130_fd_sc_hd__o21a_1 _5_ (
    .A1(_2_),
    .A2(_1_),
    .B1(_3_),
    .X(_4_)
  );
  assign _2_ = b;
  assign _1_ = a;
  assign _3_ = c;
  assign d = _4_;
endmodule
```

</details>

Follow the below commands to simulate the GLS using iverilog and gtkwave,

```
iverilog verilog_files/blocking_caveat_netlist.v verilog_files/tb_blocking_caveat.v lib/verilog_model/primitives.v lib/verilog_model/sky130_fd_sc_hd.v

./a.out

gtkwave tb_blocking_caveat.vcd
```

Below screenshot shows the simulation of the generated netlist with the same testbench,

<img src="images/Lab11/11_58.png" alt="DFF_Async_Reset" width="800"/><br>

</details>


---

<a name="Lab12"></a>

<details>
<summary>

Lab 12: Risc-V Core Synthesis using Yosys and Post Synthesis BabySoc Simulation

</summary>

In this task, we will synthesize our RISC-V core which was earlier designed in verilog HDL.

```
read_liberty -lib lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog -I src/include/ -I src/module/ src/module/clk_gate.v src/module/RV_CPU.v
synth -top RV_CPU
dfflibmap -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty lib/sky130_fd_sc_hd__tt_025C_1v80.lib
write_verilog -noattr src/module/RV_CPU_netlist.v
```
Below screenshot shows the synthesis output report,

<img src="images/Lab12/12_1.png" alt="DFF_Async_Reset" width="800"/><br>


<br>

After generating the netlist, we will be doing the gate level simulation with the BabySoC model. 

The BabySoC model will be having the gate level synthesized CPU core, DAC module and PLL module.

Following are the commands to compile using iverilog and waveform visualization using gtkwave,

```
iverilog -DFUNCTIONAL -DUNIT_DELAY=#1 -DPOST_SYNTH_SIM src/module/RV_CPU_tb.v -I src/module/ -I src/include/ -I lib/verilog_model/
./a.out
gtkwave post_synth_sim.vcd
```

Following screenshot shows the gate level synthesis simulation output in gtkwave,

<img src="images/Lab12/12_2.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the output waveform more zoomed-in,

<img src="images/Lab12/12_3.png" alt="DFF_Async_Reset" width="800"/><br>


If we compare the above waveforms with the pre synthesis waveforms, we can observe that the results are same.

Below is the screenshot which shows output waveform for simulation before synthesis,

<img src="images/Lab10/tb_output_full.png" alt="DFF_Async_Reset" width="800"/><br>


Following screenshot shows some of the standard cells implemented in the synthesized verilog file,

<img src="images/Lab12/12_4.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the signals of a standard cell,

<img src="images/Lab12/12_5.png" alt="DFF_Async_Reset" width="800"/><br>

</details>

---


<a name="Lab13"></a>


## Lab 13: Static Timing Analysis for Synthesized Risc-V Core using OpenSTA

### What is STA?

Static Timing Analysis (STA) is a method used in digital circuit design to verify the timing performance of a circuit without requiring dynamic simulation. It checks whether the circuit meets its timing constraints by analyzing the timing paths in the design. Here are some key aspects of STA:

1. Timing Paths: STA evaluates all possible paths through a circuit from input to output, taking into account the propagation delays of gates and interconnects.

2. Setup and Hold Times: It checks for setup and hold time violations. The setup time is the minimum time before the clock edge that the input data must be stable, while the hold time is the minimum time after the clock edge that the data must remain stable.

3. Clock Constraints: STA incorporates clock definitions, including the clock frequency, period, and any variations (like skew or jitter).

4. Worst-case Scenario: STA assumes worst-case conditions for delay values (like maximum load, temperature, and voltage) to ensure that the circuit will perform correctly under all expected operating conditions.

5. Tools: There are various tools for performing STA, such as Synopsys PrimeTime, Cadence Tempus, and others, which automate the process and provide detailed reports on timing violations.

Overall, STA is crucial for ensuring that digital circuits operate reliably at the intended speeds and for identifying potential timing issues early in the design process.

### Why STA is performed ?

Static Timing Analysis (STA) is performed for several critical reasons in digital circuit design:

1. Timing Verification: STA ensures that the design meets its specified timing constraints. It verifies that data signals can propagate through the circuit within the required time limits, ensuring that outputs are stable and valid when needed.

2. Identify Timing Violations: It helps identify setup and hold time violations, which can lead to incorrect operation of flip-flops and other sequential elements. Detecting these violations is crucial to ensure the reliability of the circuit.

3. Performance Optimization: By analyzing the timing paths, designers can identify critical paths that limit the maximum operating frequency. This information can be used to optimize the design by resizing gates, adjusting the layout, or modifying the clock strategy.

4. Early Detection of Issues: STA allows for early detection of timing issues during the design process, reducing the risk of costly iterations and revisions in later stages, such as post-layout or during fabrication.

5. Power Consumption Analysis: Timing analysis can also help in understanding the impact of clock frequency on power consumption. By ensuring that the design runs at optimal speeds, designers can balance performance and power efficiency.

6. Design Validation: STA provides a level of assurance that the design will work correctly under the specified operating conditions. It validates the design against its intended specifications and requirements.

7. Automation: STA tools can automatically analyze complex designs, making it more efficient than traditional dynamic simulations, especially for large-scale integrated circuits.

8. Support for Variability: STA can incorporate variations in manufacturing processes, temperature, and voltage (PVT variations) to ensure robust performance across different conditions.

In summary, STA is essential for ensuring the functionality, reliability, and performance of digital circuits, enabling designers to create high-quality, efficient designs.

### What is reg2reg Path ?

A reg2reg path (register-to-register path) refers to a timing path in a digital circuit that connects two sequential elements, specifically flip-flops or registers. This path is crucial in the context of Static Timing Analysis (STA) because it represents the flow of data from one register to another through combinational logic.

Reg2reg paths are essential for ensuring proper data flow and synchronization in digital circuits, especially in designs with pipelining or sequential operations. Analyzing these paths helps in verifying that the data processing occurs correctly across clock cycles, thereby ensuring the overall functionality and reliability of the circuit.

#### Key characteristics of reg2reg Path

1. **Sequential Logic**: Reg2reg paths are part of sequential circuits where data is stored in registers and passed from one register to another after being processed by combinational logic.

2. **Setup and Hold Timing**:
   * **Hold Time**: Reg2reg paths are analyzed for setup time constraints to ensure that the data output from the first register (FF1) arrives at the second register (FF2) before the clock edge that triggers FF2.
   * **Hold Time**: These paths are also evaluated for hold time constraints to ensure that the data remains stable at the input of FF2 for a specified period after the clock edge that triggers FF1.

3. **Combinational Logic Delay**: The timing analysis of a reg2reg path includes the propagation delay through the combinational logic that connects the two registers. This delay can vary based on the logic elements and their configuration.

4. **Critical Paths**: Reg2reg paths can often be critical paths if they take longer than other paths in the design, which can limit the maximum operating frequency of the circuit.

5. **Path Analysis**: STA tools evaluate reg2reg paths to check for timing violations, allowing designers to optimize the circuit by adjusting the logic, resizing gates, or modifying the layout.

6. **Clock Domain Crossing**: If the two registers belong to different clock domains, additional considerations for metastability and synchronization are needed, which complicates the reg2reg timing analysis.

### What is clk2reg Path ?

A clk2reg path (clock-to-register path) refers to a timing path in a digital circuit that connects the clock signal to a register (flip-flop). This path is crucial for ensuring that the register operates correctly in response to clock events. Here are the key aspects of clk2reg paths:

1. **Clock Signal Propagation**: The clk2reg path represents the time it takes for the clock signal to reach the register from the clock source, including any delays introduced by clock buffers or routing.

2. **Setup Timing**: In the context of setup timing analysis, the clk2reg path is important for determining when the data signal must arrive at the register relative to the clock edge. The analysis ensures that the clock arrives at the register before the data input becomes stable, meeting the setup time requirement.

3. **Clock Delay**: This path is evaluated for the delay introduced by any clock distribution elements, such as buffers and inverters, that may be part of the clock tree. The total delay impacts the timing of when the register captures the input data.

4. **Critical Paths**: A clk2reg path can become a critical path if the delay through this path is significant enough to affect the maximum frequency of operation for the circuit.

5. **Hold Timing**: Although clk2reg paths are primarily associated with setup time analysis, they can also be relevant for hold time analysis, especially in cases where the clock signal may have some jitter or variations that could affect timing margins.

6. **Clock Diagram Crossing**: If the register is part of a different clock domain, the clk2reg analysis will also involve considerations for synchronization and potential metastability issues.

### STA for the synthesized RISC-V Core

Here, in this activity we will be generating setup and hold timing reports for our Synthesized RISC-V Core module.

Following are the commands to generate the reports,

```
read_liberty lib/sta/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog src/module/RV_CPU_netlist.v
link_design RV_CPU

create_clock -name clk -period 10.35 [get_ports clk]
set_clock_uncertainty [expr 0.05 * 10.35] -setup [get_clocks clk]
set_clock_uncertainty [expr 0.08 * 10.35] -hold [get_clocks clk]
set_clock_transition [expr 0.05 * 10.35] [get_clocks clk]
set_input_transition [expr 0.08 * 10.35] [all_inputs]


report_checks -path_delay max
report_checks -path_delay min
```

* The clock period has been specified as 10.35 ns.
* The setup uncertainity is 5% of the defined clock period
* The clock transition is defined as 5% of the defined clock period
* The hold uncertainity is set as 8% of the clock period
* The input data transition is set as 8% of the defined clock period


In the below screenshot, we can observe the timing report for a reg2reg max path,

<img src="images/Lab13/13_1.png" alt="DFF_Async_Reset" width="800"/><br>

Below screenshot shows the reg2reg min path report,

<img src="images/Lab13/13_2.png" alt="DFF_Async_Reset" width="800"/><br>


The max path report is for the Setup Slack and the min path report is for the Hold Slack.

---