    function withdraw (
        uint256 _amount
    )
    public returns (bool) {
        require(msg.sender == admin);
        msg.sender.transfer(_amount);
        return true;
    }