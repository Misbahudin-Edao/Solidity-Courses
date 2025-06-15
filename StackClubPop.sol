// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
    address[] public members;

    // Constructor adds deployer as first member
    constructor() {
        members.push(msg.sender);
    }

    // Modifier to allow only members
    modifier onlyMember() {
        require(isMember(msg.sender), "Not a member!");
        _;
    }

    // Add new member (only existing members can add)
    function addMember(address newMember) external onlyMember {
        members.push(newMember);
    }

    // Remove last added member (only members can remove)
    function removeLastMember() external onlyMember {
        require(members.length > 0, "No members to remove!");
        members.pop();
    }

    // Check if an address is a member
    function isMember(address member) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == member) {
                return true;
            }
        }
        return false;
    }
}
