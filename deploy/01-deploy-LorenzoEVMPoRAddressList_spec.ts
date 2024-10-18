/* Imports: Internal */
import { DeployFunction } from 'hardhat-deploy/dist/types'
import { ethers } from 'hardhat';
import { LorenzoEVMPoRAddressList__factory, LorenzoPoRAddressList__factory } from '../typechain-types';

const deployFn: DeployFunction = async (hre) => {
  const [deployer] = await ethers.getSigners();
  
  const PoRInfos = [
    {
      chain: "bnb",
      chainId: 56,
      tokenSymbol: "BTCB",
      tokenAddress: "0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c",
      vaultAddress: "0xdE2BA910eBDCC53FC8a11dcD51aDe24E3eD5c3fC",
    },
    {
      chain: "bnb",
      chainId: 56,
      tokenSymbol: "BTCB",
      tokenAddress: "0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c",
      vaultAddress: "0x70451b1AF665F490df5aC86c15F5162a383A594B",
    },
    {
      chain: "b2",
      chainId: 223,
      tokenSymbol: "B2 BTC",
      tokenAddress: "0x0000000000000000000000000000000000000001",
      vaultAddress: "0xb8119F2ccfA504735c14D381cf888d1D267dbe43",
    }
  ];
  
  const lorenzoEVMPoRContract = await new LorenzoEVMPoRAddressList__factory(deployer).deploy(PoRInfos, deployer.address);
  const lorenzoEVMPoRAddr = await lorenzoEVMPoRContract.getAddress();
  console.log("lorenzoEVMPoRAddr address: ", lorenzoEVMPoRAddr)
}

// This is kept during an upgrade. So no upgrade tag.
deployFn.tags = ['DeployLorenzoEVMPoR']

export default deployFn
