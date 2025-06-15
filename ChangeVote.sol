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

    // Internal helper to find index of a voter; -1 means not found
    function _findVoterIndex(address voter) internal view returns (int) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return int(i);
            }
        }
        return -1;
    }

    // Create a vote, only if sender hasn't voted before
    function createVote(Choices choice) public {
        require(
            _findVoterIndex(msg.sender) == -1,
            "Already voted! One vote per address."
        );
        votes.push(Vote(choice, msg.sender));
    }

    // Check if an address has voted
    function hasVoted(address voter) external view returns (bool) {
        return _findVoterIndex(voter) != -1;
    }

    // Find the choice of a voter; reverts if voter hasn't voted
    function findChoice(address voter) external view returns (Choices) {
        int idx = _findVoterIndex(voter);
        require(idx != -1, "Voter has not voted");
        return votes[uint(idx)].choice;
    }

    // Change existing vote choice; reverts if voter hasn't voted
    function changeVote(Choices newChoice) external {
        int idx = _findVoterIndex(msg.sender);
        require(idx != -1, "You haven't voted yet!");
        votes[uint(idx)].choice = newChoice;
    }
}
