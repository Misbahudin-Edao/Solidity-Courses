// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
     function double(uint value) external pure returns (uint) {
        return value * 2;
     }
     function double(uint a, uint b) external pure returns (uint, uint) {
        return (a * 2, b * 2);
    }
      function callDouble() public view returns (uint, uint) {
        return this.double(1, 2); // correct way to call external function from inside
    }

}