// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "remix_tests.sol";
import "contracts/./MyCredential.sol";

contract CredentialTest {
    StudentCredential cred;
    bytes32 testHash = keccak256("student001");

    function beforeEach() public {
        cred = new StudentCredential();
    }
    function testIssueCredential() public {
        cred.issueCredential(
            testHash, "Arjun Mehta",
            "B.Tech CSE", "KU", 2024
        );
        (bool valid,) = cred.verifyCredential(testHash);
        Assert.equal(valid, true, "Should be valid");
    }

    function testRevokeCredential() public {
        cred.issueCredential(testHash, "Test", "Deg", "Uni", 2024);
        cred.revokeCredential(testHash);
        (bool valid,) = cred.verifyCredential(testHash);
        Assert.equal(valid, false, "Should be revoked");
    }
}

