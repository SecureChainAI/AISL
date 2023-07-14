function claimTokens(address _token) public onlyController {
    if (_token == 0x0) {
        controller.transfer(this.balance);
        return;
    }

    Pinakion token = Pinakion(_token);
    uint balance = token.balanceOf(this);
    token.transfer(controller, balance);
    ClaimedTokens(_token, controller, balance);
}
