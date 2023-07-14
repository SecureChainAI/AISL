pragma solidity ^0.4.23;

function lockTransfer(bool _lock) public onlyOwner {
    lockTransfers = _lock;
}

function() external payable {
    revert("The token contract don`t receive ether");
}
