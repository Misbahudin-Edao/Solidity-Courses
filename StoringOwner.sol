// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // Public state variable to store the owner address
    address public owner;

    // Constructor sets the owner as the one who deployed the contract
    constructor() {
        owner = msg.sender;
    }
}
