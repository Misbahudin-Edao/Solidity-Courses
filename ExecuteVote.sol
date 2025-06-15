// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;

    mapping(uint => mapping(address => bool)) public votes;
    mapping(uint => mapping(address => bool)) public hasVoted;

    mapping(address => bool) public members;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId, bool success);

    constructor(address[] memory initialMembers) {
        members[msg.sender] = true;
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
            Proposal({
                target: _target,
                data: _data,
                yesCount: 0,
                noCount: 0,
                executed: false
            })
        );
        uint proposalId = proposals.length - 1;
        emit ProposalCreated(proposalId);
    }

    function castVote(uint proposalId, bool support) external onlyMember {
        require(proposalId < proposals.length, "Invalid proposal ID");
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");

        if (hasVoted[proposalId][msg.sender]) {
            bool previousVote = votes[proposalId][msg.sender];
            if (previousVote != support) {
                // Update counts
                if (previousVote) {
                    proposal.yesCount--;
                } else {
                    proposal.noCount--;
                }
                if (support) {
                    proposal.yesCount++;
                } else {
                    proposal.noCount++;
                }
                votes[proposalId][msg.sender] = support;
            }
            emit VoteCast(proposalId, msg.sender);
        } else {
            hasVoted[proposalId][msg.sender] = true;
            votes[proposalId][msg.sender] = support;

            if (support) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            emit VoteCast(proposalId, msg.sender);
        }

        // Check if yesCount reached threshold and not executed yet
        if (proposal.yesCount >= 10 && !proposal.executed) {
            proposal.executed = true;

            // Execute proposal by calling target with data
            (bool success, ) = proposal.target.call(proposal.data);
            emit ProposalExecuted(proposalId, success);
        }
    }
}
