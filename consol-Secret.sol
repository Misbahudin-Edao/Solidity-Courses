// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(
        string calldata secretMessage
    ) external returns (uint) {
        console.log("Secret message received:", secretMessage);

        // Return 794 as the secret number to win!
        return 794;
    }
}
