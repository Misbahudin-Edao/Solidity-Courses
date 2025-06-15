// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices {
        Yes,
        No
    }

    // Create a Vote struct with choice and voter
    struct Vote {
        Choices choice;
        address voter;
    }

    // Public state variable to store the current vote
    Vote public vote;

    function createVote(Choices choice) external {
        // Create a new vote with the passed choice and sender address
        vote = Vote(choice, msg.sender);
    }
}
