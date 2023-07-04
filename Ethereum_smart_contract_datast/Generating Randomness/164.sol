  function getRamdon() private view returns (uint) {
      bytes32 ramdon = keccak256(abi.encodePacked(ramdon,now,blockhash(block.number-1)));
      for(uint i = 0; i < addressArray.length; i++) {
            ramdon = keccak256(abi.encodePacked(ramdon,now, addressArray[i]));
      }
      uint index  = uint(ramdon) % addressArray.length;
      return index;
    }