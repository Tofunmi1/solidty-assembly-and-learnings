- Transction components
- - nonce: number of transactions sent by address of txn sender
- - gasPrice
- - gasLimit
- - to , address of the recipient
- - value : amount of wei to be transfered
- - v,r,s : for generating signature that identifies the sender of tx
- - init
- - data

##### gas and payment

- Every computataion that occurs requires a gas fee
- Each opcode requires gas (operation code) -- instruction sets

##### How ethereum works

```py
### this is the intrinsic validity check
def APPLY(state, TX):
 if not TX.is_valid(): return ERROR
 if not TX.check_sig(): return ERROR
 if TX.sender.nonce != TX.nonce: return ERROR # if sender nonce == txn nonce
 fee = txn.gas * txn.gasprice
 decrement(tx.sender.balance, fee ) # returns error if not enough balance
 tx.sender.nonce += 1
 gas = txn.gas - (tx.bytes * miner.gas_per_byte)
 transfer(txn.value, txn.sender,txn.reciever)
```

##### EVM state is 8 tuple

```js
{
  block_state, // also references storage
    transaction, // current transaction
    message, //current message
    code, //current contract's code
    memory, //  memory byte array
    stack, // words on the stack
    pc, // program counter -> code[pc]
    gas; //gas left to run tx
}
```

- Each opcode either put on the stack or remove from the stack
- using solc --bin --asm to compile, the tags the really important part
- the EVM
- Data structures to contain instructions and operands(+, \*,-)
- a call stack for function call stack
- instruction pointer to point to the next instruction to execute
- the virtual CPU
- - Fetches the next instruction
- - Decodes the operands
- - Executes the instruction

#### Difference between stack and register based VMs

- Stack uses the last in first out stack to hold temporary values(means everything is in the memory)
- Size of each stack item in the EVM is 256bit
- Stack has a max size of 1024

#### EVM storage

- The evm has memoryy, where items are stored as word addressed bytes
- - The memory is volatile and not permanent

- The EVM also has key/value storage
- - i.e a dictionary for address space(for easier access)
- - storage is not volatile and is stored as part of the system state

- -The EVM stores program code seperatly in a virtual ROM that can be accessed via special instructions
- - The has it's own language, The EVM bytecode, compiled from solidity

#### Why EVM uses a 256 bit word

- Because sha3 (sha256) private's key usses 2 secp256k1/EDCSA with 2 256-bit uints(r, s)

- remember 160-bit account addresses fit into 256-bit

[![alt](./Screenshot%20from%202022-05-07%2016-30-32.png)]

#### solc compile process

- Parsing transforms a stream of souce code bytes into an abstract syntax tree(AST)

- A tree

#### video 2

- Memory in the EVM
- - stack memory (available in function scope)
- - Memory(available throughout the contract call)
- - storage (persists between contract calls)
- - calldata (special readonly memory for storing transaction metadata)

#### Memory type

- linear array of bytes
- arithmetic can be performed to calculate indices
- Operations for dealing with memory
- - mload(address) - retrieve value at a given address
- - mstore(address, value) - store value at a given address
- - msize - current memory size

#### Big note

- in an array, the array elements are stored in memory, plus the length of the array stored first
  ![alt](./Screenshot%20from%202022-05-07%2020-32-41.png)
- - in the above case, 4 is the length of the array

##### Storage Type

- stored in a Merkle-Patricia tree
- Every variable has a slot and offset
- offset is the displacement of an adddress
- variable in storage has a slot and offset
- variable X = x_slot and x_offset
- sload(slot + offset)
- sslot(slot + ofsfet, value)

##### cont
- offset is the distance or displacement of from the top of the stack
- Bytes and string behave the same way in solidity
- always store values in the memory in hexadecimal
- well, according to first principles thinking, the stack holds almost anything, the opcodes offsets, the memory locations, etc, anything