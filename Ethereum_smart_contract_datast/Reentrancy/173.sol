pragma solidity ^0.4.24;

function transferETH() external isOwner {
    if (this.balance == 0) throw;
    if (!ethFundDeposit.send(this.balance)) throw;
}
