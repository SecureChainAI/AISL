        uint256 roundTime = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1)))) % 6;
