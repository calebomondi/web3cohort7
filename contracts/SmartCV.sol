// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


// library 
// struct - profile  - name, title, summary, website, phone* and email* - adding DID
// struct - Role - company, role, startDate, endDate and summary, highlights - unix - 0099090890
// struct - Education - institution, focusArea, startYear and finishYear
// struct - Publication - name/title link(devpost..etc) language
// struct - Skill - name(Solidity, TS, Js) level (50)

library CVSections {
    struct profile  {
        string _name;
        string _title;
        string summary; 
        string website;
        string phone; 
        string email; 
    }

    struct Role { 
        string company; 
        string role;
        string startDate;
        string endDate;
        string summary; 
        string highlights; 
    }

    struct Education {
        string institution; 
        string focusArea; 
        string startYear;
        string finishYear;
    }

    struct Project {
        string name; 
        string link; 
        string description; 
    }
    
    struct Publication {
        string title;
        string link;
        string language;
    }
     
    struct  Skill { 
        string name;
        int32 level; 
    }
}


contract myCV {
    mapping (string => string) Profile;
    address owner;

    CVSections.Project[] public projects;
    CVSections.Education[] public educations;
    CVSections.Skill[] public skills;
    CVSections.Publication[] public publications;

    modifier  onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor () {
        owner = msg.sender;
    }

    // key - title value - smart contract dev

    function setProfileData (string memory key, string memory value) public onlyOwner() {
        Profile[key] = value;
    }

    function editProfileData(string memory key, string memory value) public onlyOwner() {
        Profile[key] = value;
    }

    // true/false, projectDonation, www.....com, its a donation project 
    function editProject(bool operation, string memory _name, string memory _link, string memory _description ) public onlyOwner() {
        if(operation) {
            projects.push(CVSections.Project(_name, _link, _description));
        } else {
            delete projects[projects.length - 1];
        }
    }

    // challenge - refactor this part 
    function editEducation(bool operation, string memory _name, string memory _focusArea, string memory _startYear, string memory _finishYear ) public onlyOwner() {
        if(operation) {
            educations.push(CVSections.Education(_name, _focusArea, _startYear, _finishYear));
        } else {
            delete educations[educations.length - 1];
        }
    }

    function editSkill (bool _operation, string memory _name, int32 _level) public onlyOwner() {
        if(_operation){
        skills.push(CVSections.Skill(_name, _level));
        } else {
            delete skills[skills.length - 1];  
        }

    }
    
    function editPublication (bool operation, string memory name, string memory link, string memory language) public onlyOwner() {
        if(operation){
            publications.push(CVSections.Publication(name, link, language ));
        } else {
            delete publications[skills.length - 1];  
        }
    }

    function getProfileData (string memory arg) public view  returns (string memory) {
        return Profile[arg];
    }

}