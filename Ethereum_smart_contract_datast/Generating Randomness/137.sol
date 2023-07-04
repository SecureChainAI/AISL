        uint256 randNum = uint256(keccak256(abi.encodePacked(tokenId, blockHash))) % probabilityByRarity;
        bytes32 rarityMask = _shiftLeft(bytes32(1), (random % 16 + 240));
        