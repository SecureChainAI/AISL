pragma solidity ^0.4.23;

address public marketingProfitAddress = 0x0;

function setMarketingProfitAddress(
        address _addr
    ) public onlyOwner onlyInState(State.Init) {
        require(_addr != address(0));
        marketingProfitAddress = _addr;
    }
function _withdrawProfit() internal {
        /**
         * @dev Distributing profit
         * the function start automatically every time when contract receive a payable transaction
         */

        uint256 marketingProfit = myAddress.balance.mul(30).div(100); // 30%
        uint256 lawSupportProfit = myAddress.balance.div(20); // 5%
        uint256 hostingProfit = myAddress.balance.div(20); // 5%
        uint256 teamProfit = myAddress.balance.div(10); // 10%
        uint256 contractorsProfit = myAddress.balance.div(20); // 5%
        uint256 saasApiProfit = myAddress.balance.div(20); // 5%
        //uint256 neironixProfit =  myAddress.balance.mul(40).div(100); // 40% but not use. Just transfer all rest

        if (marketingProfitAddress != address(0)) {
            marketingProfitAddress.transfer(marketingProfit);
            emit Withdraw(msg.sender, marketingProfitAddress, marketingProfit);
        }

        if (lawSupportProfitAddress != address(0)) {
            lawSupportProfitAddress.transfer(lawSupportProfit);
            emit Withdraw(
                msg.sender,
                lawSupportProfitAddress,
                lawSupportProfit
            );
        }

        if (hostingProfitAddress != address(0)) {
            hostingProfitAddress.transfer(hostingProfit);
            emit Withdraw(msg.sender, hostingProfitAddress, hostingProfit);
        }

        if (teamProfitAddress != address(0)) {
            teamProfitAddress.transfer(teamProfit);
            emit Withdraw(msg.sender, teamProfitAddress, teamProfit);
        }

        if (contractorsProfitAddress != address(0)) {
            contractorsProfitAddress.transfer(contractorsProfit);
            emit Withdraw(
                msg.sender,
                contractorsProfitAddress,
                contractorsProfit
            );
        }

        if (saasApiProfitAddress != address(0)) {
            saasApiProfitAddress.transfer(saasApiProfit);
            emit Withdraw(msg.sender, saasApiProfitAddress, saasApiProfit);
        }

        require(neironixProfitAddress != address(0));
        uint myBalance = myAddress.balance;
        neironixProfitAddress.transfer(myBalance);
        emit Withdraw(msg.sender, neironixProfitAddress, myBalance);
    }