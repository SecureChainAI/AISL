function CreatorWithdraw(uint index) internal {
    MatchBet storage oMatch = MatchList[index];
    if (oMatch.ownerDrawed) return;
    if (oMatch.SHA_WIN == 0) return;
    oMatch.ownerDrawed = true;
    uint allWinBet;
    if (oMatch.SHA_WIN == oMatch.SHA_T1) {
        allWinBet = oMatch.allbet1;
    } else if (oMatch.SHA_WIN == oMatch.SHA_T2) {
        allWinBet = oMatch.allbet2;
    } else {
        allWinBet = oMatch.allbet0;
    }
    if (oMatch.allbet == allWinBet) return;
    if (allWinBet == 0) {
        //nobody win, get all bet
        owner.transfer(oMatch.allbet);
    } else {
        //somebody win, withdraw tax
        uint alltax = ((oMatch.allbet - allWinBet) * REWARD_TAX) / REWARD_BASE;
        owner.transfer(alltax);
    }
}
