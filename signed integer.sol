// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 12;
    int8 public b = -4;
    int16 public difference;

    constructor() {
        difference = getAbsoluteDifference(a, b);
    }

    function getAbsoluteDifference(int8 x, int8 y) public pure returns (int16) {
        int16 diff = int16(x) - int16(y);
        return diff >= 0 ? diff : -diff;
    }
}

