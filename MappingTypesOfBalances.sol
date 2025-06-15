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
        require(!users[msg.sender].isActive, "User already exists!");

        users[msg.sender] = User({balance: 100, isActive: true});
    }

    // Transfer function
    function transfer(address recipient, uint amount) external {
        // Check if both sender and recipient are active users
        require(users[msg.sender].isActive, "Sender is not an active user");
        require(users[recipient].isActive, "Recipient is not an active user");

        // Check if sender has enough balance
        require(users[msg.sender].balance >= amount, "Insufficient balance");

        // Perform the transfer
        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
    }
}
