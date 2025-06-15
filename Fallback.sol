// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function makeContact(address hero) external {
        // Send some random bytes that definitely don't match any function selector
        bytes memory randomData = hex"deadbeef";

        (bool success, ) = hero.call(randomData);
        require(success, "Call failed");
    }
}
