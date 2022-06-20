



abstract contract BlockUpdater {
    function verifyBlocks(bytes32[] calldata blockhashes, bytes32 proof) internal virtual;

    function updateBlock(bytes32[] calldata blockhashes, bytes32 proof, uint256[] calldata totalDifficulty) public {
        verifyBlocks(blockhashes, proof);

        // handling the canonical 
    }

    struct BlockInfo {
        uint256 blockNumber;
        uint256 totalDifficulty;
    }

    bytes32[] public canonical;
    mapping(bytes32 => BlockInfo) public blocks;
}