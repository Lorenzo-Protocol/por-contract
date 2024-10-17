// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;

abstract contract BalancerRateProviderStorage {
    /// @dev total tvl for lorenzo protocol
    uint256 public totalTVL;

    /// @dev stBTC total supply
    uint256 public stBTCTotalSupply;
}
