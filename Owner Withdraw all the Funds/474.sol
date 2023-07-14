function withdrawEther(
    address _account
) public payable onlyOwner whenNotPaused returns (bool success) {
    _account.transfer(address(this).balance);

    emit Withdraw(this, _account, address(this).balance);
    return true;
}
