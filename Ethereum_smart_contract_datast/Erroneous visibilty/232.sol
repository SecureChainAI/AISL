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
 modifier onlyTier() {
    if (msg.sender != address(tier)) throw;
    _;
  }

  function setTier(address _tier) onlyOwner {
    assert(_tier != address(0));
    assert(tier == address(0));
    tier = _tier;
  }

  function FlatPricingExt(uint _oneTokenInWei) onlyOwner {
    require(_oneTokenInWei > 0);
    oneTokenInWei = _oneTokenInWei;
  }

  function updateRate(uint newOneTokenInWei) onlyTier {
    oneTokenInWei = newOneTokenInWei;
    RateChanged(newOneTokenInWei);
  }
