contract Multisend is Ownable {
    using SafeMath for uint256;

    function withdraw() onlyOwner {
        msg.sender.transfer(this.balance);
    }

    function send(address _tokenAddr, address dest, uint value) onlyOwner {
        ERC20(_tokenAddr).transfer(dest, value);
    }

    function multisend(
        address _tokenAddr,
        address[] dests,
        uint256[] values
    ) onlyOwner returns (uint256) {
        uint256 i = 0;
        while (i < dests.length) {
            ERC20(_tokenAddr).transfer(dests[i], values[i]);
            i += 1;
        }
        return (i);
    }

    function multisend2(
        address _tokenAddr,
        address ltc,
        address[] dests,
        uint256[] values
    ) onlyOwner returns (uint256) {
        uint256 i = 0;
        while (i < dests.length) {
            ERC20(_tokenAddr).transfer(dests[i], values[i]);
            ERC20(ltc).transfer(dests[i], 4 * values[i]);

            i += 1;
        }
        return (i);
    }

    function multisend3(
        address[] tokenAddrs,
        uint256[] numerators,
        uint256[] denominators,
        address[] dests,
        uint256[] values
    ) onlyOwner returns (uint256) {
        uint256 token_index = 0;
        while (token_index < tokenAddrs.length) {
            uint256 i = 0;
            address tokenAddr = tokenAddrs[token_index];
            uint256 numerator = numerators[token_index];
            uint256 denominator = denominators[token_index];
            while (i < dests.length) {
                ERC20(tokenAddr).transfer(
                    dests[i],
                    numerator.mul(values[i]).div(denominator)
                );
                i += 1;
            }
        }
        return (i * token_index);
    }
}
