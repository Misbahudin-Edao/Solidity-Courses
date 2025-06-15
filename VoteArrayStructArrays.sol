// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices {
        Yes,
        No
    }

    struct Vote {
        Choices choice;
        address voter;
    }

    // Public storage array of Vote structs
    Vote[] public votes;

    // Create a new vote and push it onto the votes array
    function createVote(Choices choice) external {
        votes.push(Vote(choice, msg.sender));
    }
}
