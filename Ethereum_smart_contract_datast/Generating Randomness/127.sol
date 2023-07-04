contract Random {
    uint256 _seed;

    function _rand() internal returns (uint256) {
        _seed = uint256(keccak256(abi.encodePacked(_seed, blockhash(block.number - 1), block.coinbase, block.difficulty)));
        return _seed;
    }

    function _randBySeed(uint256 _outSeed) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(_outSeed, blockhash(block.number - 1), block.coinbase, block.difficulty)));
    }
}