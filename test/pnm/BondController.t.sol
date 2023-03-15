// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.3;

import "@pwnednomore/contracts/PTest.sol";
import "forge-std/StdInvariant.sol";

import "../../src/Counter.sol";

import {BondController} from "tranche/BondController.sol";
import {Tranche} from "tranche/Tranche.sol";
import {BondFactory} from "tranche/BondFactory.sol";
import {LoanRouter} from "tranche/LoanRouter.sol";
import {TrancheFactory} from "tranche/TrancheFactory.sol";
import {UniV2LoanRouter} from "tranche/UniV2LoanRouter.sol";
import {UniV3LoanRouter} from "tranche/UniV3LoanRouter.sol";
import {WamplLoanRouter} from "tranche/WamplLoanRouter.sol";
import {WethLoanRouter} from "tranche/WethLoanRouter.sol";

contract BondControllerTest is PTest {
    uint256 forkId;
    Counter counter;

    Tranche tranche = Tranche(0xa07Df4a1721bF151104234A8B73B93e5E371f7e8);
    BondController bondController =
        BondController(0x8c624D6a336edE5da3bDA01574cF091A938EA906);

    address USER = address(0x1);
    address agent;

    function setUp() external {
        forkId = vm.createSelectFork(vm.rpcUrl("mainnet"), 16833213);

        counter = new Counter();
        // targetContract(address(tranche));
        // targetContract(address(bondController));

        agent = getAgent();
        hoax(agent, 1 ether);
    }

    // Invariants:
    // - `totalDebt` should always equal the sum of all tranche tokens' `totalSupply()`
    function invariantTotalDebt() external view {
        assert(bondController.totalDebt() == tranche.totalSupply());
    }
}
