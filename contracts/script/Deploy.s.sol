// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MultiFaucet.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        MultiFaucet faucet = new MultiFaucet();
        
        vm.stopBroadcast();
        
        console.log("MultiFaucet deployed to:", address(faucet));
        console.log("Chain ID:", block.chainid);
        console.log("ETH drip amount:", faucet.ETH_AMOUNT());
    }
}
