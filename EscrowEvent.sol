// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // Event to log the approval and amount transferred
    event Approved(uint amount);

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve");

        uint balance = address(this).balance;

        // Transfer the full contract balance to the beneficiary
        payable(beneficiary).transfer(balance);

        // Emit the Approved event
        emit Approved(balance);
    }
}