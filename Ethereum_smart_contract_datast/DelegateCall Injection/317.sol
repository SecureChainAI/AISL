contract Delegation {
    address public owner;
    Delegate delegate;

    function Delegation(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    // an attacker can call Delegate.pwn() in the context of Delegation
    // this means that pwn() will modify the state of **Delegation** and not Delegate
    // the result is that the attacker takes unauthorized ownership of the contract
    function() {
        if (delegate.delegatecall(msg.data)) {
            this;
        }
    }
}
