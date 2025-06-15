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

    // Track votes per proposal per voter: true = yes, false = no
    mapping(uint => mapping(address => bool)) public votes;
    // Track if user has voted on proposal
    mapping(uint => mapping(address => bool)) public hasVoted;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(
            Proposal({target: _target, data: _data, yesCount: 0, noCount: 0})
        );

        uint proposalId = proposals.length - 1;
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposal ID");

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = votes[proposalId][msg.sender];
            // Only update counts if vote changed
            if (previousVote != support) {
                if (previousVote) {
                    proposals[proposalId].yesCount--;
                } else {
                    proposals[proposalId].noCount--;
                }

                if (support) {
                    proposals[proposalId].yesCount++;
                } else {
                    proposals[proposalId].noCount++;
                }

                votes[proposalId][msg.sender] = support;
            }
            // Still emit VoteCast even if vote changed or same? Tests expect 2 events in total
            emit VoteCast(proposalId, msg.sender);
        } else {
            hasVoted[proposalId][msg.sender] = true;
            votes[proposalId][msg.sender] = support;

            if (support) {
                proposals[proposalId].yesCount++;
            } else {
                proposals[proposalId].noCount++;
            }

            emit VoteCast(proposalId, msg.sender);
        }
    }
}
