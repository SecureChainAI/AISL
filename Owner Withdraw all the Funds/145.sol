pragma solidity 0.4.24;

function reclaimEther() external onlyOwner {
    owner.transfer(address(this).balance);
}
