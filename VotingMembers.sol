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

    // Track votes per proposal per voter
    mapping(uint => mapping(address => bool)) public votes;
    mapping(uint => mapping(address => bool)) public hasVoted;

    // Members whitelist
    mapping(address => bool) public members;

    // EVENTS
    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // Constructor: initialize members whitelist (including deployer)
    constructor(address[] memory initialMembers) {
        members[msg.sender] = true; // deployer is a member too

        for (uint i = 0; i < initialMembers.length; i++) {
            members[initialMembers[i]] = true;
        }
    }

    modifier onlyMember() {
        require(members[msg.sender], "Not a voting member");
        _;
    }

    function newProposal(
        address _target,
        bytes calldata _data
    ) external onlyMember {
        proposals.push(
            Proposal({target: _target, data: _data, yesCount: 0, noCount: 0})
        );

        uint proposalId = proposals.length - 1;
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool support) external onlyMember {
        require(proposalId < proposals.length, "Invalid proposal ID");

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = votes[proposalId][msg.sender];
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
