import {task} from 'hardhat/config'
import {BlockUpdaterForTest__factory} from "../build/types"

task('deploy:contract', 'deploy')
    .setAction(async function (args, {ethers}) {
        console.log(`[depoly contract] start`)

        // @ts-ignore
        const signer = await ethers.getSigner();
        const blockupdaterfortest_factory = <BlockUpdaterForTest__factory>await ethers.getContractFactory("BlockUpdaterForTest")
        const instance = await blockupdaterfortest_factory.deploy()
        await instance.deployed()
        console.log(`update contract deployed`)
        console.log(`----------------------------------------------------`)
        console.log(`transaction hash: ${instance.deployTransaction.hash}`)
        console.log(`contract address: ${instance.address}`)
        console.log(`initial holder: ${signer.address}`)
        console.log(`[depoly contract] end`)
    })