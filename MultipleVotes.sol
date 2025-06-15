// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    // Tracks voter -> proposalId -> vote choice (true = yes, false = no, non-voted = default)
    mapping(uint => mapping(address => bool)) public votes;
    // Tracks if an address has voted on a proposal
    mapping(uint => mapping(address => bool)) public hasVoted;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(
            Proposal({target: _target, data: _data, yesCount: 0, noCount: 0})
        );
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        if (hasVoted[proposalId][msg.sender]) {
            // Voter changing vote
            bool previousVote = votes[proposalId][msg.sender];

            if (previousVote != support) {
                // Remove previous vote count
                if (previousVote) {
                    proposals[proposalId].yesCount--;
                } else {
                    proposals[proposalId].noCount--;
                }

                // Add new vote count
                if (support) {
                    proposals[proposalId].yesCount++;
                } else {
                    proposals[proposalId].noCount++;
                }

                // Update stored vote
                votes[proposalId][msg.sender] = support;
            }
            // If same vote, do nothing (no change)
        } else {
            // First time voting
            hasVoted[proposalId][msg.sender] = true;
            votes[proposalId][msg.sender] = support;

            if (support) {
                proposals[proposalId].yesCount++;
            } else {
                proposals[proposalId].noCount++;
            }
        }
    }
}
