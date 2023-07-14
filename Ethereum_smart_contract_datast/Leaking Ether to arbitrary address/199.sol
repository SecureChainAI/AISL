pragma solidity ^0.4.24;

contract TeamJust {
    JIincForwarderInterface private Jekyll_Island_Inc =
        JIincForwarderInterface(0x0);
}

function() public payable {
    Jekyll_Island_Inc.deposit.value(address(this).balance)();
}
