interface Token {
    function distr(address _to, uint256 _value) public returns (bool);

    function totalSupply() public constant returns (uint256 supply);

    function balanceOf(
        address _owner
    ) public constant returns (uint256 balance);
}
