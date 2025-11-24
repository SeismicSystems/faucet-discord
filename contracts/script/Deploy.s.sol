// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MultiFaucet.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Get addresses from environment
        address dai = vm.envAddress("DAI_ADDRESS");
        address weth = vm.envAddress("WETH_ADDRESS");
        string memory uri = vm.envString("NFT_URI");
        
        vm.startBroadcast(deployerPrivateKey);
        
        MultiFaucet faucet = new MultiFaucet(dai, weth, uri);
        
        vm.stopBroadcast();
        
        console.log("MultiFaucet deployed to:", address(faucet));
        console.log("Chain ID:", block.chainid);
        console.log("DAI address:", dai);
        console.log("WETH address:", weth);
        console.log("NFT URI:", uri);
    }
}
