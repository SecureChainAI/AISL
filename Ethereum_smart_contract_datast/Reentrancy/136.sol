    function cancelSale(uint256 tokenId) external 
    whenNotPaused()
    originalOwnerOf(tokenId) 
    tokenAvailable() returns (bool) {
        //throws on fail - transfers token from exchange back to original owner
        token.transferFrom(address(this),msg.sender,tokenId);
        
        //Reset token on market - remove
        delete market[tokenId];

        //Reset barn tracker for user
        _removeTokenFromBarn(tokenId, msg.sender);

        emit SaleCanceled(tokenId);

        //Return true if this user is still 'active' within the exchange
        //This will help with client side actions
        return userBarn[msg.sender].length > 0;
    }
    function depositToExchange(uint256 tokenId, uint256 price) external
    whenNotPaused()
    isTokenOwner(tokenId)
    nonZeroPrice(price)
    tokenAvailable() {
        require(token.getApproved(tokenId) == address(this),"Exchange is not allowed to transfer");
        //Transfers token from depositee to exchange (contract address)
        token.transferFrom(msg.sender, address(this), tokenId);
        
        //add the token to the market
        market[tokenId] = SaleData(price,msg.sender);

        //Add token to exchange map - tracking by owner of all tokens
        userBarn[msg.sender].push(tokenId);

        emit HorseyDeposit(tokenId, price);
    }
     function getTokenPrice(uint256 tokenId) public view
    isOnMarket(tokenId) returns (uint256) {
        return market[tokenId].price + (market[tokenId].price / 100 * marketMakerFee);
    }
 function purchaseToken(uint256 tokenId) external payable 
    whenNotPaused()
    isOnMarket(tokenId) 
    tokenAvailable()
    notOriginalOwnerOf(tokenId)
    {
        //Did the sender accidently pay over? - if so track the amount over
        uint256 totalToPay = getTokenPrice(tokenId);
        require(msg.value >= totalToPay, "Not paying enough");

        //fetch this tokens sale data
        SaleData memory sale = market[tokenId];

        //Add to collected fee amount payable to DEVS
        collectedFees += totalToPay - sale.price;

        //pay the seller
        sale.owner.transfer(sale.price);

        //Reset barn tracker for user
        _removeTokenFromBarn(tokenId,  sale.owner);

        //Reset token on market - remove
        delete market[tokenId];

        //Transfer the ERC721 to the buyer - we leave the sale amount
        //to be withdrawn by the user (transferred from exchange)
        token.transferFrom(address(this), msg.sender, tokenId);

        //Return over paid amount to sender if necessary
        if(msg.value > totalToPay) //overpaid
        {
            msg.sender.transfer(msg.value - totalToPay);
        }

        emit HorseyPurchased(tokenId, msg.sender, totalToPay);
    }