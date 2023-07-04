  function create(
        address _allowedToTransferWallet,
        address _futureSaleWallet,
        address _communityWallet,
        address _foundationWallet,
        address _foundersWallet,
        address _publicPrivateSaleWallet
    ) public
    {
        token = new AbacasToken(_allowedToTransferWallet);
        // solium-disable-next-line max-len
        initialDistribution = new AbacasInitialTokenDistribution(token, _futureSaleWallet, _communityWallet, _foundationWallet, _foundersWallet, _publicPrivateSaleWallet, FOUNDERS_LOCK_START_TIME, FOUNDERS_LOCK_PERIOD);
        token.approve(initialDistribution, token.balanceOf(this));
        initialDistribution.processInitialDistribution();
        token.pause();
        transfer();
    }