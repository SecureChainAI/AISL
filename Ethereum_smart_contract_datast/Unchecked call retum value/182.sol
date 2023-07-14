contract ERC20Basic {
    function transfer(address to, uint value) public;
}

contract ERC20 is ERC20Basic {
    function transferFrom(address from, address to, uint value) public;

    function approve(address spender, uint value) public;
}
