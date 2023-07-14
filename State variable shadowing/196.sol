function registerNameXaddr(
    string _nameString,
    address _affCode,
    bool _all
) public payable isHuman {
    // make sure name fees paid
    require(
        msg.value >= registrationFee_,
        "umm.....  you have to pay the name fee"
    );

    // filter name + condition checks
    bytes32 _name = NameFilter.nameFilter(_nameString);

    // set up address
    address _addr = msg.sender;

    // set up our tx event data and determine if player is new or not
    bool _isNewPlayer = determinePID(_addr);

    // fetch player id
    uint256 _pID = pIDxAddr_[_addr];

    // manage affiliate residuals
    // if no affiliate code was given or player tried to use their own, lolz

    uint256 _affID; // Uninitialized local variables
    
    if (_affCode != address(0) && _affCode != _addr) {
        // get affiliate ID from aff Code
        _affID = pIDxAddr_[_affCode];

        // if affID is not the same as previously stored
        if (_affID != plyr_[_pID].laff) {
            // update last affiliate
            plyr_[_pID].laff = _affID;
        }
    }

    // register name
    registerNameCore(_pID, _addr, _affID, _name, _isNewPlayer, _all);
}
