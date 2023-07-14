function core(
    uint256 _rID,
    uint256 _pID,
    uint256 _eth,
    uint256 _affID,
    uint256 _team,
    F3Ddatasets.EventReturns memory _eventData_
) private {
    // if player is new to round
    if (plyrRnds_[_pID][_rID].keys == 0)
        _eventData_ = managePlayer(_pID, _eventData_);

    // early round eth limiter
    if (
        round_[_rID].eth < 100000000000000000000 &&
        plyrRnds_[_pID][_rID].eth.add(_eth) > 1000000000000000000
    ) {
        uint256 _availableLimit = (1000000000000000000).sub(
            plyrRnds_[_pID][_rID].eth
        );
        uint256 _refund = _eth.sub(_availableLimit);
        plyr_[_pID].gen = plyr_[_pID].gen.add(_refund);
        _eth = _availableLimit;
    }

    // if eth left is greater than min eth allowed (sorry no pocket lint)
    if (_eth > 1000000000) {
        // mint the new keys
        uint256 _keys = (round_[_rID].eth).keysRec(_eth);

        // if they bought at least 1 whole key
        if (_keys >= 1000000000000000000) {
            updateTimer(_keys, _rID);

            // set new leaders
            if (round_[_rID].plyr != _pID) round_[_rID].plyr = _pID;
            if (round_[_rID].team != _team) round_[_rID].team = _team;

            // set the new leader bool to true
            _eventData_.compressedData = _eventData_.compressedData + 100;
        }

        // manage airdrops
        if (_eth >= 100000000000000000) {
            airDropTracker_++;
            if (airdrop() == true) {
                // gib muni
                uint256 _prize;
                if (_eth >= 10000000000000000000) {
                    // calculate prize and give it to winner
                    _prize = ((airDropPot_).mul(75)) / 100;
                    plyr_[_pID].win = (plyr_[_pID].win).add(_prize);

                    // adjust airDropPot
                    airDropPot_ = (airDropPot_).sub(_prize);

                    // let event know a tier 3 prize was won
                    _eventData_
                        .compressedData += 300000000000000000000000000000000;
                } else if (
                    _eth >= 1000000000000000000 && _eth < 10000000000000000000
                ) {
                    // calculate prize and give it to winner
                    _prize = ((airDropPot_).mul(50)) / 100;
                    plyr_[_pID].win = (plyr_[_pID].win).add(_prize);

                    // adjust airDropPot
                    airDropPot_ = (airDropPot_).sub(_prize);

                    // let event know a tier 2 prize was won
                    _eventData_
                        .compressedData += 200000000000000000000000000000000;
                } else if (
                    _eth >= 100000000000000000 && _eth < 1000000000000000000
                ) {
                    // calculate prize and give it to winner
                    _prize = ((airDropPot_).mul(25)) / 100;
                    plyr_[_pID].win = (plyr_[_pID].win).add(_prize);

                    // adjust airDropPot
                    airDropPot_ = (airDropPot_).sub(_prize);

                    // let event know a tier 3 prize was won
                    _eventData_
                        .compressedData += 300000000000000000000000000000000;
                }
                // set airdrop happened bool to true
                _eventData_.compressedData += 10000000000000000000000000000000;
                // let event know how much was won
                _eventData_.compressedData +=
                    _prize *
                    1000000000000000000000000000000000;

                // reset air drop tracker
                airDropTracker_ = 0;
            }
        }
    }
}
