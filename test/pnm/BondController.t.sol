// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import "forge-std/Test.sol";
import "@pwnednomore/contracts/PTest.sol";
import "tranche/BondController.sol";

contract BondControllerTest is PTest {
    BondController bondController =
        BondController(0x8c624d6a336ede5da3bda01574cf091a938ea906);

    address USER = address(0x1);
    address agent;

    function setUp() external {
        agent = getAgent();
        hoax(agent, 1 ether);
        vault.deposit{value: 1 ether}();
    }

    // Invariants:
    // - `totalDebt` should always equal the sum of all tranche tokens' `totalSupply()`
    function invariantTotalDebt() external view {
        assert(bondController.totalDebt() == bondController.totalSupply());
    }
}
