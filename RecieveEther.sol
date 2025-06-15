// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Special function to receive ether without any calldata
    receive() external payable {
        // The contract can receive Ether directly now!
        // You can optionally add logging here if you want (using console.log in Foundry)
    }
}
