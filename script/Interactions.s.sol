// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint64) {
        HelperConfig helperConfig = new HelperConfig();
        (, , address vrfCoordinator, , , ) = helperConfig.activeNetworkConfig();
        console.log("Creating subscription on chainID: ", block.chainid);
        vm.startBroadcast();
        uint64 subscriptionId = VRFCoordinatorV2Mock(vrfCoordinator)
            .createSubscription();
        vm.stopBroadcast();
        console.log("Subscription Id: ", subscriptionId);
        return subscriptionId;
    }

    function run() external returns (uint64) {
        return createSubscriptionUsingConfig();
    }
}

contract FundSubscription is Script {
    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        (, , address vrfCoordinator, , uint64 subscriptionId, ) = helperConfig
            .activeNetworkConfig();
    }

    function run() external {
        fundSubscriptionUsingConfig();
    }
}
