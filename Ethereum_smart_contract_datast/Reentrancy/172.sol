pragma solidity ^0.4.23;

function buy(uint256 _amount) external payable onlyHuman {
    require(_amount > 0);
    uint256 _money = _amount.mul(price);
    require(msg.value == _money);
    require(balances[this] >= _amount);
    require((totalSupply - totalSold) >= _amount, "Sold out");
    _transfer(this, msg.sender, _amount);
    finance.transfer(_money.mul(60).div(100));
    jackpot.transfer(_money.mul(20).div(100));
    shareContract.increaseProfit.value(_money.mul(20).div(100))();
    totalSold += _amount;
}
