//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import { MerkleAirdrop, IERC20 } from "../src/MerkleAirdrop.sol";
import { Script } from "forge-std/Script.sol";
import { VadapavToken } from "../src/VadapavToken.sol";
import { console } from "forge-std/console.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private s_amountToTransfer = 4 * 25 * 1e18;
    
    function deployMerkleAirdrop() public returns (MerkleAirdrop, VadapavToken) {
        vm.startBroadcast();
        VadapavToken token = new VadapavToken();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(token)));
        token.mint(token.owner(), s_amountToTransfer);
        token.transfer(address(airdrop), s_amountToTransfer);
        vm.stopBroadcast();
        return (airdrop, token);
    }
    
    function run() external returns (MerkleAirdrop, VadapavToken) {
        return deployMerkleAirdrop();
    }
}