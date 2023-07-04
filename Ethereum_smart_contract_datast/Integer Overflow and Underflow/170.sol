  function makeCoin(uint256 _value)public returns (bool){
        require(msg.sender == owner);
        totalSupply += _value;
        balances[owner] += _value;
        return true;
    }