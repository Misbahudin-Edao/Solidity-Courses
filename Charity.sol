// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public charity;

    // Constructor accepts the charity address
    constructor(address _charity) {
        charity = _charity;
    }

    // Allow contract to receive ether
    receive() external payable {}

    // Donate all balance to charity
    function donate() external {
        uint balance = address(this).balance;

        // Transfer entire balance to charity
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed.");
    }
}
