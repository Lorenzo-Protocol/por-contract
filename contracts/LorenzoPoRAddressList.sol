// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IPoRAddressList.sol";

contract LorenzoPoRAddressList is Ownable, IPoRAddressList {
    string[] private addresses;

    constructor(
        string[] memory _addresses,
        address initialOwner
    ) Ownable(initialOwner) {
        addresses = _addresses;
    }

    function getPoRAddressListLength()
        external
        view
        override
        returns (uint256)
    {
        return addresses.length;
    }

    function getPoRAddressList(
        uint256 startIndex,
        uint256 endIndex
    ) external view override returns (string[] memory) {
        if (startIndex > endIndex) {
            return new string[](0);
        }
        endIndex = endIndex > addresses.length - 1
            ? addresses.length - 1
            : endIndex;
        string[] memory stringAddresses = new string[](
            endIndex - startIndex + 1
        );
        uint256 currIdx = startIndex;
        uint256 strAddrIdx = 0;
        while (currIdx <= endIndex) {
            stringAddresses[strAddrIdx] = addresses[currIdx];
            strAddrIdx++;
            currIdx++;
        }
        return stringAddresses;
    }

    function addAddress(string memory addr) external onlyOwner {
        if (bytes(addr).length == 0) {
            revert("Address cannot be empty");
        }
        for (uint256 i = 0; i < addresses.length; i++) {
            if (
                keccak256(abi.encodePacked(addresses[i])) ==
                keccak256(abi.encodePacked(addr))
            ) {
                revert("Address already exists");
            }
        }
        addresses.push(addr);
    }

    function removeAddress(string memory addr) external onlyOwner {
        if (bytes(addr).length == 0) {
            revert("Address cannot be empty");
        }
        for (uint256 i = 0; i < addresses.length; i++) {
            if (
                keccak256(abi.encodePacked(addresses[i])) ==
                keccak256(abi.encodePacked(addr))
            ) {
                addresses[i] = addresses[addresses.length - 1];
                addresses.pop();
                return;
            }
        }
        revert("Address not found");
    }
}
