# RISC_V_Design
Project Overview:
  This repository contains a hardware implementation of a 32-bit single-cycle RISC-V processor based on a the industry-standard RV32I Instruction Set Architecture. Designed as a non-pipelined core, the processor routes, decodes, and executes supported instruction within a single clock cycle.

Instruction Set Architecture:
  The processor handles five distinct instruction formats, balancing mathematical computations, memory operations, and program control flow modifications.
  Computational Operations (R-Type & I-Type)
    1. Register-to-Register Arithmetic: Supports basic addition and subtraction utilizing two source registers and writing back to a destination register.
    2. Register-to-Register Logic: Executes bitwise logical operations including AND, OR, and exclusive-OR (XOR) masks across the register file.
    3. Immediate Arithmetic: Performs identical mathematical and logical operations (addition, bitwise AND, OR, XOR) using a fixed, sign-extended immediate value encoded directly within the instruction stream instead of a secondary register source.
  
  Memory Interfacing (I-Type & S-Type)
    1. Data Loading: Decodes pointer arithmetic to read 32-bit data words from specific data memory addresses and writes them directly into the register file.
    2. Data Storing: Transfers 32-bit register values out to specified locations within the external data memory block for persistent storage.
    
  Control Flow & Jumps (B-Type & J-Type)
    1. Conditional Branches: Evaluates register values dynamically. If two source registers match (Equal) or mismatch (Not Equal), the program counter overrides normal sequential execution and jumps to a calculated offset.
    2. Unconditional Jumps: Forces an absolute jump to a target address relative to the current program counter while simultaneously preserving the sequential link address (return address) back into the register file to allow for modular function calls.
