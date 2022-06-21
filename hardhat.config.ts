import "@nomiclabs/hardhat-waffle";
import '@typechain/hardhat'
import * as fs from 'fs';

import './tasks'

const mnemonic = fs.readFileSync('.env').toString().trim();
module.exports = {
    hardhat: {
        accounts: {
            accountsBalance: '1000000000000000000000000000'
        },
        chainId: 31337,
        gas: 5000000,
    },
    networks: {
        bsc_test: {
            accounts: [mnemonic],
            url: 'https://data-seed-prebsc-2-s3.binance.org:8545/',
            chainId: 97,
            gas: 3000000,
            gasPrice: "auto"
        },
        eth_rinkeby: {
            accounts: [mnemonic],
            url: 'https://rinkeby.infura.io/v3/d363d254b81941a18f38f27683e50292',
            chainId: 4,
            gas: 3000000,
            gasPrice: "auto"
        },
    },
    solidity: {
        version: "0.8.14",
        settings: {
            optimizer: {
                enabled: true,
                runs: 200
            }
        }
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts"
    },
    mocha: {
        timeout: 40000
    },
    typechain: {
        outDir: "build/types",
        target: "ethers-v5"
    },
}