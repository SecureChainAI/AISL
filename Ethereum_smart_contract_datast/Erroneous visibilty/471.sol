function setTokenInformation(string _name, string _symbol) onlyOwner {
    name = _name;
    symbol = _symbol;

    UpdatedTokenInformation(name, symbol);
}

function CrowdsaleTokenExt(
    string _name,
    string _symbol,
    uint _initialSupply,
    uint _decimals,
    bool _mintable,
    uint _globalMinCap
) UpgradeableToken(msg.sender) {
    // Create any address, can be transferred
    // to team multisig via changeOwner(),
    // also remember to call setUpgradeMaster()
    owner = msg.sender;

    name = _name;
    symbol = _symbol;

    totalSupply = _initialSupply;

    decimals = _decimals;

    minCap = _globalMinCap;

    // Create initially all balance on the team multisig
    balances[owner] = totalSupply;

    if (totalSupply > 0) {
        Minted(owner, totalSupply);
    }

    // No more new supply allowed after the token creation
    if (!_mintable) {
        mintingFinished = true;
        if (totalSupply == 0) {
            throw; // Cannot create a token without supply and no minting
        }
    }
}
