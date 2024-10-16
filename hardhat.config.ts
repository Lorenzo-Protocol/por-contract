import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import * as dotenv from 'dotenv'
import 'hardhat-deploy'
dotenv.config()

const contract_deployer = process.env.DEPLOY_PRIVATE_KEY || '0x' + '11'.repeat(32)

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    hardhat: {
      gas: 29000000,
    },
    bscTestnet: {
      chainId: 97,
      url: process.env.BSC_TESTNET_RPC_URL || '',
      accounts: [contract_deployer],
    },
    bsc: {
      chainId: 56,
      url: process.env.BSC_MAINNET_RPC_URL || '',
      accounts: [contract_deployer],
    },
    arbitrum_one: {
      chainId: 42161,
      url: process.env.ARB_MAINNET_RPC_URL || '',
      accounts: [contract_deployer],
    },
    mainnet: {
      chainId: 1,
      url: process.env.ETH_MAINNET_RPC_URL || '',
      accounts: [contract_deployer],
    },
    sepolia: {
      chainId: 11155111,
      url: process.env.SEPOLIA_RPC_URL || '',
      accounts: [contract_deployer],
    }
  },
  namedAccounts: {
    deployer: {
      default: 0,
    }
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETH_MAINNET_API_KEY!,
      bscTestnet: process.env.BSC_SCAN_API_KEY!,
      bsc: process.env.BSC_SCAN_API_KEY!
    }
  }
};

export default config;
