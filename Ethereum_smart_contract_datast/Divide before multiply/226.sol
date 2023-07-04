        return(  ((((round_[_rID].mask).add(((((round_[_rID].pot).mul(potSplit_[round_[_rID].team].gen)) / 100).mul(1000000000000000000)) / (round_[_rID].keys))).mul(plyrRnds_[_pID][_rID].keys)) / 1000000000000000000)  );
 uint256 _win = (_pot.mul(48)) / 100;   //48%
        uint256 _dev = (_pot / 50);            //2%
        uint256 _gen = (_pot.mul(potSplit_[_winTID].gen)) / 100; //15
        uint256 _PoH = (_pot.mul(potSplit_[_winTID].poh)) / 100; // 10
        uint256 _res = (((_pot.sub(_win)).sub(_dev)).sub(_gen)).sub(_PoH); //25
          uint256 _ppt = (_gen.mul(1000000000000000000)) / (round_[_rID].keys);
        uint256 _dust = _gen.sub((_ppt.mul(round_[_rID].keys)) / 1000000000000000000);
            _newTime = (((_keys) / (1000000000000000000)).mul(rndInc_)).add(_now);
            _newTime = (((_keys) / (1000000000000000000)).mul(rndInc_)).add(round_[_rID].end);
   uint256 _ppt = (_gen.mul(1000000000000000000)) / (round_[_rID].keys);
        