// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// The interface for the Hero contract
interface IHero {
    function alert() external;
}

// The Sidekick contract
contract Sidekick {
    function sendAlert(address hero) external {
        // Use the interface to call alert() on the hero address
        IHero(hero).alert();
    }
}
