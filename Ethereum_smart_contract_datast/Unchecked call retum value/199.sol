interface JIincForwarderInterface {
    function deposit() external payable returns (bool);
}

function() public payable {
    Jekyll_Island_Inc.deposit.value(address(this).balance)();
}
