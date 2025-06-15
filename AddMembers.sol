// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // Mapping of address to bool indicating membership
    mapping(address => bool) public members;

    // Function to add a member
    function addMember(address newMember) external {
        members[newMember] = true;
    }
}
