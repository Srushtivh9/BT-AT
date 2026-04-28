// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentCredential {

    struct Credential {
        string  studentName;
        string  degree;
        string  institution;
        uint256 year;
        bool    isValid;
    }

    mapping(bytes32 => Credential) private credentials;
    address public owner;
    function generateHash(string memory studentId) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(studentId));
}
    event CredentialIssued(bytes32 indexed credHash);
    event CredentialRevoked(bytes32 indexed credHash);

    constructor() { owner = msg.sender; }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function issueCredential(
        bytes32 credHash,
        string memory name,
        string memory degree,
        string memory institution,
        uint256 year
    ) public onlyOwner {
        credentials[credHash] = Credential(
            name, degree, institution, year, true
        );
        emit CredentialIssued(credHash);
    }
    function verifyCredential(bytes32 credHash)
        public view returns (bool, string memory)
    {
        Credential memory c = credentials[credHash];
        return (c.isValid, c.studentName);
    }
    
    function revokeCredential(bytes32 credHash)
        public onlyOwner
    {
        credentials[credHash].isValid = false;
        emit CredentialRevoked(credHash);
    }
}
