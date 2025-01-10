// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DaoProposal {

    struct Proposal {
        address owner;
        string title;
        string description;
        uint256 proposalId;
        bool executed; 
        uint256 votedYes;
        uint256 votedNo;
        string startTime;
        string endTime;
    } // type of proposal

    enum Vote {
        Yes, 
        No
    }

    //   improve items adding events 

    mapping(uint => Proposal) public Proposals;
    uint256 public ProposalCount = 0;
    mapping(address => mapping(uint256 => bool)) votes;


    function createProposal(string memory _title, string memory _description, string memory _startTime, string memory _endTime) 
        external returns(uint256) 
    {
        Proposal storage proposal = Proposals[ProposalCount];
        proposal.owner = msg.sender;
        proposal.proposalId = ProposalCount; // index 0
        proposal.title = _title;
        proposal.executed = false;
        proposal.description = _description;
        proposal.startTime = _startTime;
        proposal.endTime = _endTime;

        ProposalCount++;

        return ProposalCount - 1;
    }

    // vote on a proposal
    function voteOnProposal(uint proposalID, Vote vote) external {
        Proposal storage proposal = Proposals[proposalID];
        require(proposal.owner != address(0), "The proposal does not exist");
        require(votes[msg.sender][proposal.proposalId] == false, "You have already voted on this proposal");

        if (vote == Vote.Yes) {
            proposal.votedYes++;
        } else {
            proposal.votedNo++; 
        }

        votes[msg.sender][proposal.proposalId] = true;
    }

    // exceute proposal

}
