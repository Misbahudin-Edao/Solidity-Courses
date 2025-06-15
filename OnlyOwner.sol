// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;

    error NotOwner(address caller);

    constructor() payable {
        owner = msg.sender;
    }

    // Withdraw all funds to the owner, only callable by the owner
    function withdraw() public {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }

        // Transfer all ether to the owner
        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Withdrawal failed");
    }

    // Just in case contract needs to receive ether
    receive() external payable {}
}
