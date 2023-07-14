function transfer(address token, address[] to, uint[] value) public onlyOwner {
    require(to.length == value.length);
    require(token != address(0));

    ERC20 t = ERC20(token);
    for (uint i = 0; i < to.length; i++) {
        t.transfer(to[i], value[i]);
    }
}
