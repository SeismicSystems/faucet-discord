// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.30;

/// ============ Imports ============

import "./utils/SeismicFaucetTest.sol"; // SeismicFaucet ds-test

/// ============ Libraries ============

library Errors {
    string constant NotSuperOperator = "Not super operator";
    string constant NotApprovedOperator = "Not approved operator";
}

/// ============ Functionality testing ============

contract Tests is SeismicFaucetTest {
    /// @notice Allow dripping ETH to recipient, if super operator
    function testDrip() public {
        // Bob before balance
        uint256 bobETHBalanceBefore = BOB.ETHBalance();

        // Alice drips to bob
        ALICE.drip(address(BOB));

        // Bob after balance - should receive 1 ETH
        assertEq(BOB.ETHBalance(), bobETHBalanceBefore + 1 ether);
    }

    /// @notice Prevent dripping if not approved operator
    function testCannotDripIfNotOperator() public {
        assertErrorFunctionWithAddress(BOB.drip, address(ALICE), Errors.NotApprovedOperator);
    }

    /// @notice Can add approved operator and they can drip
    function testAddApprovedOperator() public {
        // Alice adds Bob as approved operator
        ALICE.updateApprovedOperator(address(BOB), true);

        // Ensure Bob is an approved operator
        assertTrue(FAUCET.approvedOperators(address(BOB)));

        // Ensure Bob can drip
        BOB.drip(address(ALICE));
    }

    /// @notice Can remove approved operator and they can't drip
    function testRemoveApprovedOperator() public {
        // Alice adds Bob as approved operator
        ALICE.updateApprovedOperator(address(BOB), true);
        assertTrue(FAUCET.approvedOperators(address(BOB)));

        // Alice removes Bob as approved operator
        ALICE.updateApprovedOperator(address(BOB), false);
        assertTrue(!FAUCET.approvedOperators(address(BOB)));

        // Bob can no longer drip
        assertErrorFunctionWithAddress(BOB.drip, address(ALICE), Errors.NotApprovedOperator);
    }

    /// @notice Can update super operator
    function testUpdateSuperOperator() public {
        // Alice gives super operatorship to BOB
        ALICE.updateSuperOperator(address(BOB), true);

        // Verify Bob is now a super operator
        assertTrue(FAUCET.superOperators(address(BOB)));

        // Alice removes her super operatorship
        ALICE.updateSuperOperator(address(ALICE), false);

        // Alice can no longer drip
        assertErrorFunctionWithAddress(ALICE.drip, address(BOB), Errors.NotApprovedOperator);

        // Bob can add Alice to super operators
        BOB.updateApprovedOperator(address(ALICE), true);
        assertTrue(FAUCET.approvedOperators(address(ALICE)));

        // Alice can now drip
        ALICE.drip(address(BOB));

        // Alice can still not update super operator
        assertErrorFunctionWithAddressAndBool(ALICE.updateSuperOperator, address(ALICE), true, Errors.NotSuperOperator);
    }

    /// @notice Can drain contract if super operator
    function testCanDrainFaucet() public {
        // Bob before balance
        uint256 bobETHBalanceBefore = BOB.ETHBalance();

        // Alice drains to bob
        ALICE.drain(address(BOB));

        // Bob after balance - should receive all 100 ETH from faucet
        assertEq(BOB.ETHBalance(), bobETHBalanceBefore + 100 ether);
    }

    /// @notice Cannot drain contract if not super operator
    function testCannotDrainIfNotSuperOperator() public {
        assertErrorFunctionWithAddress(BOB.drain, address(BOB), Errors.NotSuperOperator);
    }

    /// @notice Returns correct number of available ETH drips
    function testCorrectDripCount() public {
        uint256 ethDrips = FAUCET.availableDrips();
        assertEq(ethDrips, 100); // 100 ETH / 1 ETH per drip = 100 drips
    }

    /// @notice Allows super operators to update drip amount
    function testAllowsUpdatingDripAmount() public {
        // Bob before balance
        uint256 bobETHBalanceBefore = BOB.ETHBalance();

        // Alice updates drip amount to 0.5 ETH
        ALICE.updateDripAmount(0.5 ether);

        // Alice drips to bob
        ALICE.drip(address(BOB));

        // Bob after balance - should receive 0.5 ETH
        assertEq(BOB.ETHBalance(), bobETHBalanceBefore + 0.5 ether);
    }
}
