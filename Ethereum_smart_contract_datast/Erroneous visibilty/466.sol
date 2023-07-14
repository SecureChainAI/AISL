library SafeMathLibExt {
    function times(uint a, uint b) returns (uint) {
        uint c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function divides(uint a, uint b) returns (uint) {
        assert(b > 0);
        uint c = a / b;
        assert(a == b * c + (a % b));
        return c;
    }

    function minus(uint a, uint b) returns (uint) {
        assert(b <= a);
        return a - b;
    }

    function plus(uint a, uint b) returns (uint) {
        uint c = a + b;
        assert(c >= a);
        return c;
    }
}

function distributeReservedTokens(uint reservedTokensDistributionBatch);

function finalizeCrowdsale();

function setStartsAt(uint time) onlyOwner {
    assert(!finalized);
    assert(isUpdatable);
    assert(now <= time); // Don't change past
    assert(time <= endsAt);
    assert(now <= startsAt);

    CrowdsaleExt lastTierCntrct = CrowdsaleExt(getLastTier());
    if (lastTierCntrct.finalized()) throw;

    uint8 tierPosition = getTierPosition(this);

    //start time should be greater then end time of previous tiers
    for (uint8 j = 0; j < tierPosition; j++) {
        CrowdsaleExt crowdsale = CrowdsaleExt(joinedCrowdsales[j]);
        assert(time >= crowdsale.endsAt());
    }

    startsAt = time;
    StartsAtChanged(startsAt);
}

function transferFrom(
    address _from,
    address _to,
    uint _value
) canTransfer(_from) returns (bool success) {
    // Call StandardToken.transferForm()
    return super.transferFrom(_from, _to, _value);
}
