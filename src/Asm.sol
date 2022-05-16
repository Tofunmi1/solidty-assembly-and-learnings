////// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Asm {
 function asmLoops() public pure returns(uint _r){
   uint i = 0;
  assembly{
   for { i := 0 } lt(i, 10) { i := add(i, 1)} {
     _r := add(_r, 1)
   }
   mstore(0x0, _r)
   return(0x0, 32)
  }
 }
  
 function asmSumOfArray(uint[] memory arr) public pure returns(uint sum) {
   assembly{
     let len := mload(arr) // this is because an array is stored like (len(array) + array_elements)
     let elementAddress := add(arr, 0x20) //0x20 = 256bit = 32bytes,      
     for{ let i := 0 } lt(i, len) { i := add(i, 1)}{
       
       sum := add(sum, mload(elementAddress))
       
       elementAddress := add(elementAddress, 0x20) //we want to get what is after 256bits, since each object in memory is 256bits long // whch is 32bytes
     }
       mstore(0x0, sum)
       return(0x0, 0x20)
   }

 }

  function asmThingsA(bytes memory slength) public pure {
    assembly{
      let x := 7
      let y := add(x, 7)
      let z := add(keccak256(0x0, 0x20), div(slength, 32))
    }

    assembly{
      let a := 0x123 //hexadecimal
      let b := 42 //decimal
      let c := "Hello mom!" //string lenght must not be more than 32 bytes

      function allocate(length) -> pos {
        pos := mload(0x40)
        mstore(0x40, add(pos, length))
      }
      let free_memory_pointer := allocate(64) 
    }
  }

  function switchCase() public pure {
    
    assembly{
      let x := 34
      switch lt(x, 30)
      case true{
        //okkay do this
      }
    }

    assembly{
      switch calldataload(4)
      case 0{

      }
    }

  }
}
