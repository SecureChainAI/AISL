function determineNextRoundLength() internal view returns (uint256 time) {
    uint256 roundTime = uint256(
        keccak256(abi.encodePacked(blockhash(block.number - 1)))
    ) % 6;
    return roundTime;
}
