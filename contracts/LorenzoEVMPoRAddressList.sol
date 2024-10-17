// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IEVMPoRAddressList.sol";

contract LorenzoEVMPoRAddressList is Ownable, IEVMPoRAddressList {
    PoRInfo[] private porInfos;

    constructor(
        PoRInfo[] memory _porInfos,
        address initialOwner
    ) Ownable(initialOwner) {
        for (uint i = 0; i < _porInfos.length; i++) {
            porInfos.push(_porInfos[i]);
        }
    }

    function getPoRAddressListLength()
        external
        view
        override
        returns (uint256)
    {
        return porInfos.length;
    }

    function getPoRAddressList(
        uint256 startIndex,
        uint256 endIndex
    ) external view override returns (PoRInfo[] memory) {
        if (startIndex > endIndex) {
            return new PoRInfo[](0);
        }
        endIndex = endIndex > porInfos.length - 1
            ? porInfos.length - 1
            : endIndex;
        PoRInfo[] memory stringAddresses = new PoRInfo[](
            endIndex - startIndex + 1
        );
        uint256 currIdx = startIndex;
        uint256 strAddrIdx = 0;
        while (currIdx <= endIndex) {
            stringAddresses[strAddrIdx] = porInfos[currIdx];
            strAddrIdx++;
            currIdx++;
        }
        return stringAddresses;
    }

    function addPoRInfo(PoRInfo memory porInfo) external onlyOwner {
        porInfos.push(porInfo);
    }

    function removePoRInfo(PoRInfo memory porInfo) external onlyOwner {
        for (uint256 i = 0; i < porInfos.length; i++) {
            if (
                porInfos[i].chainId == porInfo.chainId &&
                porInfos[i].tokenAddress == porInfo.tokenAddress &&
                porInfos[i].vaultAddress == porInfo.vaultAddress
            ) {
                porInfos[i] = porInfos[porInfos.length - 1];
                porInfos.pop();
                return;
            }
        }
        revert("PoRInfo not found");
    }
}
