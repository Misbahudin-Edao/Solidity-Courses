// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public depositor;
    address public arbiter;
    address public beneficiary;

    // Event to notify when approval happens and how much was sent
    event Approved(uint256 balance);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only arbiter can approve");

        uint256 balance = address(this).balance;

        payable(beneficiary).transfer(balance);

        emit Approved(balance); // 🎉 Event emitted right after transfer
    }
}
