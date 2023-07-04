   function withdraw() public{
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
    /*将合约中的ETH提取到某个地址中 需求拥有者权限
     */
    function withdrawTo(address _to) public{
        require(msg.sender == owner);
        address(_to).transfer(address(this).balance);
    }