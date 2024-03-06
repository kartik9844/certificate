require("@matterlabs/hardhat-zksync-solc");
const PRIVATE_KEY="74c77f8d954e002d3cf4cd9821a2963b447af02f106133cf62838f9565e382f7"; 
const RPC_URL="https://rpc.ankr.com/polygon_mumbai";
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  zksolc: {
    version: "1.3.9",
    compilerSource: "binary",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  defaultNetwork:"polygon_mumbai",
  networks: {
    hardhat: {
      chainId: 80001,
  },
  polygon_mumbai: {
    url: RPC_URL, 
    accounts: [`0x${PRIVATE_KEY}`] 
  }
},
  // paths: {
  //   artifacts: "./artifacts-zk",
  //   cache: "./cache-zk",
  //   sources: "./contracts",
  //   tests: "./test",
  // },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
