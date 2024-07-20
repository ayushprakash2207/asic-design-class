# ASIC Design Class

# Table of contents
1. [Compilation of C code in GCC compiler](#Lab1A)
2. [Compilation of C code in RISC-V GCC compiler](#Lab1B)
3. [Execution of the output object file of RISC-V GCC compiler in Spike Simulator](#Lab2)

---
<a name="Lab1A"></a>

## Lab 1A: Create a small C program to count from 1 to n and compile it using GCC compiler.

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

---

<a name="Lab1B"></a>

## Lab 1B: Compile the same C program created as a part of Lab1A in RISC-V GCC compiler.

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
  
---

<a name="Lab2"></a>

## Lab 2: Execution of the object file created by the RISC-V GCC compiler using Spike Simulator.

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

---