// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

abstract contract BlockUpdater {
    function verifyBlocks(bytes32[] calldata blockhashes, bytes32 proof) internal virtual;

    constructor(bytes32 genesisHash, uint256 totalDifficulty) {
        BlockInfo memory tempInfo;

        tempInfo.blockNumber = 0;
        tempInfo.totalDifficulty = totalDifficulty;

        blocks[genesisHash] = tempInfo;
        canonical.push(genesisHash);
    }

    function updateBlock(bytes32[] calldata blockhashes, bytes32 proof, uint256[] calldata totalDifficulty) public {
        verifyBlocks(blockhashes, proof);

        // make sure the known block
        bytes32 parent = blockhashes[0];
        BlockInfo storage parentInfo = blocks[parent];
        BlockInfo memory tempInfo;

        require(parent == canonical[0] || parentInfo.blockNumber != 0, 'Cannot find parent');

        for (uint i = 1; i < blockhashes.length; i++) {    
            tempInfo.blockNumber = i + parentInfo.blockNumber;
            tempInfo.totalDifficulty = totalDifficulty[i];

            blocks[blockhashes[i]] = tempInfo;
        }
        bytes32 h = canonical[canonical.length - 1];

        if (blocks[h].totalDifficulty < totalDifficulty[totalDifficulty.length - 1]) {
            // reorg
            for (uint i = 1; i < blockhashes.length; i++) {    
                uint number = i + parentInfo.blockNumber;
                if (number >= canonical.length) {
                    canonical.push(blockhashes[i]);
                } else {
                    canonical[number] = blockhashes[i];
                }
            }
        }
    }

    function head() public view returns(uint256 blockNumber, bytes32 the_hash, uint256 totalDifficulty) {
        blockNumber = canonical.length;
        the_hash = canonical[blockNumber];
        totalDifficulty = blocks[the_hash].totalDifficulty;
    }

    struct BlockInfo {
        uint256 blockNumber;
        uint256 totalDifficulty;
    }

    bytes32[] public canonical;
    mapping(bytes32 => BlockInfo) public blocks;
}
