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

    Vote[] public votes;

    // Add a new vote
    function createVote(Choices choice) external {
        votes.push(Vote(choice, msg.sender));
    }

    // Internal helper to find index of a voter in the votes array; returns -1 if not found
    function _findVoterIndex(address voter) internal view returns (int) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return int(i);
            }
        }
        return -1;
    }

    // Check if address has voted
    function hasVoted(address voter) external view returns (bool) {
        return _findVoterIndex(voter) != -1;
    }

    // Find the choice of a given voter (assumes voter has voted)
    function findChoice(address voter) external view returns (Choices) {
        int idx = _findVoterIndex(voter);
        require(idx != -1, "Voter has not voted");
        return votes[uint(idx)].choice;
    }
}
