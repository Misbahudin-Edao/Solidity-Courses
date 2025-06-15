// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // Mapping of address to bool indicating membership
    mapping(address => bool) public members;

    // Function to add a member
    function addMember(address newMember) external {
        members[newMember] = true;
    }

    // Function to check if an address is a member
    function isMember(address addr) external view returns (bool) {
        return members[addr];
    }

    // Function to remove a member
    function removeMember(address addr) external {
        members[addr] = false;
    }
}
