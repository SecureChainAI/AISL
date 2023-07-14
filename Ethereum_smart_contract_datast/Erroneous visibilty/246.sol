function withdrawJuror() {
    withdrawSelect(msg.sender);
}

/** @dev Withdraw the funds of a given juror
 *  @param _juror The address of the juror
 */
function withdrawSelect(address _juror) {
    uint amount = withdraw[_juror];
    withdraw[_juror] = 0;

    balance = sub(balance, amount); // Could underflow
    remainingWithdraw = sub(remainingWithdraw, amount);

    // The juror receives d + p + e (deposit + p + epsilon)
    require(pinakion.transfer(_juror, amount));
}

function withdrawAttacker() {
    require(settled);

    if (balance > remainingWithdraw) {
        // The remaning balance of PNK after settlement is transfered to the attacker.
        uint amount = balance - remainingWithdraw;
        balance = remainingWithdraw;

        require(pinakion.transfer(attacker, amount));
    }
}
