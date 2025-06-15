// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    function filterEven(
        uint[] calldata numbers
    ) external pure returns (uint[] memory) {
        // First, count how many even numbers we have
        uint count = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                count++;
            }
        }

        // Initialize memory array with exactly the right size
        uint[] memory evens = new uint[](count);

        // Fill the new array with even numbers
        uint index = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evens[index] = numbers[i];
                index++;
            }
        }

        return evens;
    }
}
