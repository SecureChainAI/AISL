contract FinalizeAgent {
    function distributeReservedTokens(uint reservedTokensDistributionBatch);

    /** Called once by crowdsale finalize() if the sale was success. */
    function finalizeCrowdsale();
}

function transfer(
    address _to,
    uint _value
) canTransfer(msg.sender) returns (bool success) {
    // Call StandardToken.transfer()
    return super.transfer(_to, _value);
}

function NullFinalizeAgentExt(CrowdsaleExt _crowdsale) {
    crowdsale = _crowdsale;
}
