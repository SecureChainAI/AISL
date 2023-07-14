function getPlayerVaultsHelper(
    uint256 _pID,
    uint256 _rID
) private view returns (uint256) {
    return (
        ((
            (
                (round_[_rID].mask).add(
                    (
                        ((
                            (round_[_rID].pot).mul(
                                potSplit_[round_[_rID].team].gen
                            )
                        ) / 100).mul(1000000000000000000)
                    ) / (round_[_rID].keys)
                )
            ).mul(plyrRnds_[_pID][_rID].keys)
        ) / 1000000000000000000)
    );
}

function updateTimer(uint256 _keys, uint256 _rID) private {
    // grab time
    uint256 _now = now;

    uint256 _rndInc = rndInc_;

    if (round_[_rID].pot > rndLimit_) {
        _rndInc = _rndInc / 2;
    }

    // calculate time based on number of keys bought
    uint256 _newTime;
    if (_now > round_[_rID].end && round_[_rID].plyr == 0)
        _newTime = (((_keys) / (1000000000000000000)).mul(_rndInc)).add(_now);
    else
        _newTime = (((_keys) / (1000000000000000000)).mul(_rndInc)).add(
            round_[_rID].end
        );

    // compare to max and set new end time
    if (_newTime < (rndMax_).add(_now)) round_[_rID].end = _newTime;
    else round_[_rID].end = rndMax_.add(_now);
}
