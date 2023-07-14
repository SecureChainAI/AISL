function registerNameCore(
    uint256 _pID,
    address _addr,
    uint256 _affID,
    bytes32 _name,
    bool _isNewPlayer,
    bool _all
) private {
    // if names already has been used, require that current msg sender owns the name
    if (pIDxName_[_name] != 0)
        require(
            plyrNames_[_pID][_name] == true,
            "sorry that names already taken"
        );

    // add name to player profile, registry, and name book
    plyr_[_pID].name = _name;
    pIDxName_[_name] = _pID;
    if (plyrNames_[_pID][_name] == false) {
        plyrNames_[_pID][_name] = true;
        plyr_[_pID].names++;
        plyrNameList_[_pID][plyr_[_pID].names] = _name;
    }

    
    reward.send(address(this).balance); //Send function doesn't checked the retuen value 

    // push player info to games
    if (_all == true)
        for (uint256 i = 1; i <= gID_; i++)
            games_[i].receivePlayerInfo(_pID, _addr, _name, _affID);

    // fire event
    emit onNewName(
        _pID,
        _addr,
        _name,
        _isNewPlayer,
        _affID,
        plyr_[_affID].addr,
        plyr_[_affID].name,
        msg.value,
        now
    );
}
