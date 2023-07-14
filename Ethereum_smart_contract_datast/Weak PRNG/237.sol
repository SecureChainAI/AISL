function random() private view returns (uint8) {
    return uint8(uint256(keccak256(block.timestamp, block.difficulty)) % 251);
}

function random2() private view returns (uint8) {
    return uint8(uint256(keccak256(blocks, block.difficulty)) % 251);
}

function random3() private view returns (uint8) {
    return
        uint8(uint256(keccak256(blocks, block.difficulty)) % braggers.length);
}
