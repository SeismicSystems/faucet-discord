// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/SeismicFaucet.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        SeismicFaucet faucet = new SeismicFaucet();
        
        vm.stopBroadcast();
        
        console.log("SeismicFaucet deployed to:", address(faucet));
        console.log("Chain ID:", block.chainid);
        console.log("ETH drip amount:", faucet.ETH_AMOUNT());
    }
}
