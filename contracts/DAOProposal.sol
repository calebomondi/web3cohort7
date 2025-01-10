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
        uint256 startTime;
        uint256 endTime;
    } // type of proposal

    enum Vote {
        Yes, 
        No
    }

    //   improve items adding events 
    event  ProposalsCreated(
        uint256 indexed proposalID, 
        string title,
        address indexed  owner, 
        uint32 duration
    );
    event VoteCasted(
        uint indexed proposalID, 
        address indexed voter,
        Vote vote,
        uint256 timestamp
    );

    mapping(uint => Proposal) public Proposals;
    uint256 public ProposalCount = 0;
    mapping(address => mapping(uint256 => bool)) votes;


    function createProposal(string memory _title, string memory _description, uint32 duration) 
        external returns(uint256) 
    {
        Proposal storage proposal = Proposals[ProposalCount];
        proposal.owner = msg.sender;
        proposal.proposalId = ProposalCount; // index 0
        proposal.title = _title;
        proposal.executed = false;
        proposal.description = _description;
        proposal.startTime = block.timestamp;
        proposal.endTime = block.timestamp + (duration * 1 days);

        ProposalCount++;

        emit ProposalsCreated(ProposalCount - 1, _title, msg.sender, duration);

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

        emit VoteCasted(proposalID, msg.sender, vote, block.timestamp);
    }

    // exceute proposal
    modifier  onlyOwner (uint256 proposalID){
        require(msg.sender == Proposals[proposalID].owner, "You are not the owner of this proposal");
        _;
    }

    function executeProposal (uint256 proposalID) external onlyOwner(proposalID) {
        require(!Proposals[proposalID].executed, "This proposal has already been executed ");
        
        Proposals[proposalID].executed = true;
    }

}
