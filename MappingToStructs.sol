// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // Define the User struct
    struct User {
        uint balance;
        bool isActive;
    }

    // Mapping of address to User struct
    mapping(address => User) public users;

    // Create new user function
    function createUser() external {
        // Check if user is already active
        require(!users[msg.sender].isActive, "User already exists!");

        // Create the new user with 100 tokens and set isActive to true
        users[msg.sender] = User({balance: 100, isActive: true});
    }
}
