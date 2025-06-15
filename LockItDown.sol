// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    // Public addresses of the parties
    address public depositor;
    address public arbiter;
    address public beneficiary;

    // Constructor: set addresses and make contract payable for funding
    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender; // Whoever deploys is the depositor
        arbiter = _arbiter; // Arbiter address
        beneficiary = _beneficiary; // Beneficiary address
    }

    // Approve function: only arbiter can call this to release funds
    function approve() external {
        require(msg.sender == arbiter, "Only arbiter can approve");
        payable(beneficiary).transfer(address(this).balance);
    }
}
