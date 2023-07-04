 function airdrop()
        private 
        view 
        returns(bool)
    {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            
            (block.timestamp).add
            (block.difficulty).add
            ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (now)).add
            (block.gaslimit).add
            ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (now)).add
            (block.number)
            
        )));
        if((seed - ((seed / 1000) * 1000)) < airDropTracker_)
            return(true);
        else
            return(false);
    }
        uint256 _now = now;
 round_[_rID].strt = now;
        round_[_rID].end = now.add(rndInit_).add(rndGap_);
        uint256 _now = now;
            ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (now)).add
            ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (now)).add
        _eventData_.compressedData = _eventData_.compressedData + (now * 1000000000000000000) + (_team * 100000000000000000000000000000);
    round_[1].strt = now + rndExtra_ - rndGap_;
        round_[1].end = now + rndInit_ + rndExtra_;
        uint256 _now = now;
