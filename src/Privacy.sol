// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrivacyExploit {
    function castBytes32To16(bytes32 _bytes32) external pure returns (bytes16) {
        return bytes16(_bytes32);
    }
}

interface IPrivacy {
    function unlock(bytes16 _key) external;
}
