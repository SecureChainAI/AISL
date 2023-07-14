pragma solidity ^0.4.24;

function transfer(
    address _wallet,
    uint _reward
) external onlyMintHelper returns (bool) {
    /* Verify our mining leader isn't trying to over reward its wallets. */
    if (_reward > lastRewardAmount) {
        return false;
    }

    /* Reduce the last reward amount. */
    lastRewardAmount = lastRewardAmount.sub(_reward);

    /* Transfer the ZeroGold to mining leader. */
    zeroGold.transfer(_wallet, _reward);
}
