// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    // Define the enum for connection types
    enum ConnectionTypes {
        Unacquainted,
        Friend,
        Family,
        Colleague
    }

    // Create the nested mapping: address => (address => ConnectionTypes)
    mapping(address => mapping(address => ConnectionTypes)) public connections;

    // Function to create a connection from msg.sender to another address
    function connectWith(
        address other,
        ConnectionTypes connectionType
    ) external {
        connections[msg.sender][other] = connectionType;
    }

    // (Optional) Helper function to check your connection with someone
    function getConnection(
        address from,
        address to
    ) external view returns (ConnectionTypes) {
        return connections[from][to];
    }
}
