// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./interfaces/IRateProvider.sol";
import "./storage/BalancerRateProviderStorage.sol";

contract BalancerRateProvider is
    OwnableUpgradeable,
    IRateProvider,
    BalancerRateProviderStorage
{
    error InvalidZeroInput();

    /// @dev Prevents implementation contract from being initialized.
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @dev Initializes the contract with initial vars
    function initialize(
        address _owner,
        uint256 _totalTVL,
        uint256 _stBTCTotalSupply
    ) public initializer {
        if (_totalTVL == 0 || _stBTCTotalSupply == 0) revert InvalidZeroInput();

        __Ownable_init(_owner);
        totalTVL = _totalTVL;
        stBTCTotalSupply = _stBTCTotalSupply;
    }

    /// @dev Returns the current rate of stBTC in BTC
    function getRate() external view returns (uint256) {
        // Sanity check
        if (stBTCTotalSupply == 0 || totalTVL == 0) revert InvalidZeroInput();

        // Return the rate
        return (10 ** 18 * totalTVL) / stBTCTotalSupply;
    }

    function updateTVLAndSupply(
        uint256 _totalTVL,
        uint256 _totalSupply
    ) external onlyOwner {
        if (_totalSupply == 0 || _totalTVL == 0) revert InvalidZeroInput();

        totalTVL = _totalTVL;
        stBTCTotalSupply = _totalSupply;
    }
}
