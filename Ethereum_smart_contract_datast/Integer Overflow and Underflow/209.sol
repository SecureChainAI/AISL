/*INTERNAL TRANSFER*/
function _transfer(address _from, address _to, uint _value) internal {    
/*prevent transfer to invalid address*/    
if(_to == 0x0) revert();
/*check if the sender has enough value to send*/
if(balances[_from] < _value) revert(); 
/*check for overflows*/
if(balances[_to] + _value < balances[_to]) revert();
/*compute sending and receiving balances before transfer*/
uint PreviousBalances = balances[_from] + balances[_to];
/*substract from sender*/
balances[_from] -= _value;
/*add to the recipient*/
balances[_to] += _value; 
/*check integrity of transfer operation*/
assert(balances[_from] + balances[_to] == PreviousBalances);
/*broadcast transaction*/
emit Transfer(_from, _to, _value); 
}