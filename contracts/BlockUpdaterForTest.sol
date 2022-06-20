


import './BlockUpdater.sol';



contract BlockUpdaterForTest is BlockUpdater {
     function verifyBlocks(bytes32[] calldata blockhashes, bytes32 proof) internal override {
        // require ?  
     }
}