function withdrawAttacker() {
    require(settled);

    if (balance > remainingWithdraw) {
        // The remaning balance of PNK after settlement is transfered to the attacker.
        uint amount = balance - remainingWithdraw;
        balance = remainingWithdraw;

        require(pinakion.transfer(attacker, amount));
    }
}
