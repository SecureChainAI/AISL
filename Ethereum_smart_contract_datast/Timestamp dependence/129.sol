   function preValidatePurchase(uint256 _amount) internal {
        bool isOfferingStarted = ctuContract.isOfferingStarted();
        bool offeringEnabled = ctuContract.offeringEnabled();
        uint256 startTime = ctuContract.startTime();
        uint256 endTime = ctuContract.endTime();
        uint256 currentTotalTokenOffering = ctuContract.currentTotalTokenOffering();
        uint256 currentTokenOfferingRaisedContractium = ctuContract.currentTokenOfferingRaised();

        require(_amount > 0);
        require(isOfferingStarted);
        require(offeringEnabled);
        require(currentTokenOfferingRaised.add(currentTokenOfferingRaisedContractium.add(_amount)) <= currentTotalTokenOffering);
        require(block.timestamp >= startTime && block.timestamp <= endTime);
    }