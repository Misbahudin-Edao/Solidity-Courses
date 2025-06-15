// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint256 public x;
    constructor ( uint256 _x) {
        x = _x;

    }
    function increment() external {
        x += 1;
    }
    function callIncrement() public { 
        this.increment();
    }
     function add(uint _value) external view returns (uint) {
        return x + _value;
     }

}