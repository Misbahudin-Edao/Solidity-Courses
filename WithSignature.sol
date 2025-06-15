// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero, uint256 numEnemies, bool armed) external {
        // Encode the function call with arguments
        bytes memory payload = abi.encodeWithSignature(
            "alert(uint256,bool)",
            numEnemies,
            armed
        );

        (bool success, ) = hero.call(payload);
        require(success);
    }
}
