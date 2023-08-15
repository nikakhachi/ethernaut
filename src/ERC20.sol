// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC20/ERC20.sol";
import "openzeppelin/access/Ownable.sol";

contract ExploitToken is ERC20, Ownable {
    constructor(uint _totalSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, _totalSupply);
    }
}
