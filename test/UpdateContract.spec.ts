import {ethers} from 'hardhat'
import {BlockUpdaterForTest__factory} from "../build/types";

describe('Update Contract unit tests', () => {
    it('deploy contract', async function () {
        const blockupdaterfortest_factory = <BlockUpdaterForTest__factory>await ethers.getContractFactory("BlockUpdaterForTest")
        const instance = this.instance = await blockupdaterfortest_factory.deploy()
        await instance.deployed()
    })

    it('update block', async function () {
        const {instance} = this

    })
})
