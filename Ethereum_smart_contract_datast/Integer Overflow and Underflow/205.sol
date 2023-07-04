  function _transfer(address _from, address _to, uint _value) internal {
        // 防止转移到0x0， 用burn代替这个功能
        require(_to != 0x0);
        // 检测发送者是否有足够的资金
        require(balanceOf[_from] >= _value);
        // 检查是否溢出（数据类型的溢出）
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // 将此保存为将来的断言， 函数最后会有一个检验
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // 减少发送者资产
        balanceOf[_from] -= _value;
        // 增加接收者的资产
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
        // 断言检测， 不应该为错
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

       function _transfer(address _from, address _to, uint _value) internal {
        require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
        require (balanceOf[_from] >= _value);               // Check if the sender has enough
        require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
        require(!frozenAccount[_from]);                     // Check if sender is frozen
        require(!frozenAccount[_to]);                       // Check if recipient is frozen
        balanceOf[_from] -= _value;                         // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
        Transfer(_from, _to, _value);
    }