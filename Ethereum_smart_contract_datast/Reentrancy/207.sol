 function contribute(address _ref) public notFinished payable {

        address referral = _ref;
        uint256 referralBase = 0;
        uint256 referralTokens = 0;
        uint256 tokenBought = 0;

        if(refLed[msg.sender] == 0){ //If no referral set yet
          refLed[msg.sender] = referral; //Set referral to passed one
        } else { //If not, then it was set previously
          referral = refLed[msg.sender]; //A referral must not be changed
        }

        totalRaised = totalRaised.add(msg.value);

        //Rate of exchange depends on stage
        if (state == State.stage1){

            tokenBought = msg.value.mul(rates[0]);

        } else if (state == State.stage2){

            tokenBought = msg.value.mul(rates[1]);

        } else if (state == State.stage3){

            tokenBought = msg.value.mul(rates[2]);

        } else if (state == State.stage4){

            tokenBought = msg.value.mul(rates[3]);

        } else if (state == State.stage5){

            tokenBought = msg.value.mul(rates[4]);

        }

        //If there is any referral, the base calc will be made with this value
        referralBase = tokenBought;

        //2% Bonus Calc
        if(msg.value >= 5 ether ){
          tokenBought = tokenBought.mul(102);
          tokenBought = tokenBought.div(100); //1.02 = +2%
        }

        totalDistributed = totalDistributed.add(tokenBought);
        stageDistributed = stageDistributed.add(tokenBought);

        tokenReward.transfer(msg.sender, tokenBought);

        emit LogFundingReceived(msg.sender, msg.value, totalRaised);
        emit LogContributorsPayout(msg.sender, tokenBought);


        if (referral != address(0) && referral != msg.sender){

            referralTokens = referralBase.div(20); // 100% / 20 = 5%
            totalDistributed = totalDistributed.add(referralTokens);
            stageDistributed = stageDistributed.add(referralTokens);

            tokenReward.transfer(referral, referralTokens);

            emit LogContributorsPayout(referral, referralTokens);
        }

        checkIfFundingCompleteOrExpired();
    }