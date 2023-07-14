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
