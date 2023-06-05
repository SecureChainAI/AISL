pragma solidity ^0.4.11;

//
// SafeMath
//
// Ownable
// Destructible
// Pausable
//
// ERC20Basic
// ERC20 : ERC20Basic
// BasicToken : ERC20Basic
// StandardToken : ERC20, BasicToken
// MintableToken : StandardToken, Ownable
// PausableToken : StandardToken, Pausable
//
// VanityToken : MintableToken, PausableToken
//
// VanityCrowdsale : Ownable
//

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

/**
 * @title Destructible
 * @dev Base contract that can be destroyed by owner. All funds in contract will be sent to the owner.
 */
contract Destructible is Ownable {

  function Destructible() public payable { }

  /**
   * @dev Transfers the current balance to the owner and terminates the contract.
   */
  function destroy() onlyOwner public {
    selfdestruct(owner);
  }

  function destroyAndSend(address _recipient) onlyOwner public {
    selfdestruct(_recipient);
  }
}

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;


  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    Unpause();
  }
}

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  uint256 public totalSupply;
  function balanceOf(address who) public constant returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public constant returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {
  using SafeMath for uint256;

  mapping(address => uint256) balances;

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));

    // SafeMath.sub will throw if there is not enough balance.
    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public constant returns (uint256 balance) {
    return balances[_owner];
  }

}

/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20, BasicToken {

  mapping (address => mapping (address => uint256)) allowed;


  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));

    uint256 _allowance = allowed[_from][msg.sender];

    // Check is not needed because sub(_allowance, _value) will already throw if this condition is not met
    // require (_value <= _allowance);

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  /**
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   */
  function increaseApproval (address _spender, uint _addedValue) public
    returns (bool success) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  function decreaseApproval (address _spender, uint _subtractedValue) public
    returns (bool success) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}

/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */

contract MintableToken is StandardToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
    totalSupply = totalSupply.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    Mint(_to, _amount);
    Transfer(0x0, _to, _amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function finishMinting() onlyOwner public returns (bool) {
    mintingFinished = true;
    MintFinished();
    return true;
  }
}

/**
 * @title Pausable token
 *
 * @dev StandardToken modified with pausable transfers.
 **/

contract PausableToken is StandardToken, Pausable {

  function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
    return super.transfer(_to, _value);
  }

  function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
    return super.transferFrom(_from, _to, _value);
  }

  function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
    return super.approve(_spender, _value);
  }

  function increaseApproval(address _spender, uint _addedValue) public whenNotPaused returns (bool success) {
    return super.increaseApproval(_spender, _addedValue);
  }

  function decreaseApproval(address _spender, uint _subtractedValue) public whenNotPaused returns (bool success) {
    return super.decreaseApproval(_spender, _subtractedValue);
  }
}

contract VanityToken is MintableToken, PausableToken {

    // Metadata
    string public constant symbol = "VIP";
    string public constant name = "VipCoin";
    uint8 public constant decimals = 18;
    string public constant version = "1.0";

}

contract VanityCrowdsale is Ownable {

    using SafeMath for uint256;

    // Constants

    uint256 public constant TOKEN_RATE = 1000; // 1 ETH = 1000 VPL
    uint256 public constant OWNER_TOKENS_PERCENT = 100; // 1:1

    // Variables

    uint256 public startTime;
    uint256 public endTime;
    address public ownerWallet;
    
    mapping(address => uint) public registeredInDay;
    address[] public participants;
    uint256 public totalUsdAmount;
    uint256 public bonusMultiplier;
    
    VanityToken public token;
    bool public finalized;
    bool public distributed;
    uint256 public distributedCount;
    uint256 public distributedTokens;
    
    // Events

    event Finalized();
    event Distributed();
    
    // Constructor and accessors

    function VanityCrowdsale(uint256 _startTime, uint256 _endTime, address _ownerWallet) public {
        startTime = _startTime;
        endTime = _endTime;
        ownerWallet = _ownerWallet;

        token = new VanityToken();
        token.pause();
    }

    function registered(address wallet) public constant returns(bool) {
        return registeredInDay[wallet] > 0;
    }

    function participantsCount() public constant returns(uint) {
        return participants.length;
    }

    function setOwnerWallet(address _ownerWallet) public onlyOwner {
        require(_ownerWallet != address(0));
        ownerWallet = _ownerWallet;
    }

    function computeTotalEthAmount() public constant returns(uint256) {
        uint256 total = 0;
        for (uint i = 0; i < participants.length; i++) {
            address participant = participants[distributedCount + i];
            total += participant.balance;
        }
        return total;
    }

    function setTotalUsdAmount(uint256 _totalUsdAmount) public onlyOwner {
        totalUsdAmount = _totalUsdAmount;

        if (totalUsdAmount > 10000000) {
            bonusMultiplier = 20;
        } else if (totalUsdAmount > 5000000) {
            bonusMultiplier = 15;
        } else if (totalUsdAmount > 1000000) {
            bonusMultiplier = 10;
        } else if (totalUsdAmount > 100000) {
            bonusMultiplier = 5;
        } else if (totalUsdAmount > 10000) {
            bonusMultiplier = 2;
        } else if (totalUsdAmount == 0) {
            bonusMultiplier = 0; //TODO: set 1
        }
    }

    // Participants methods

    function () public payable {
        registerParticipant();
    }

    function registerParticipant() public payable {
        require(!finalized);
        require(startTime <= now && now <= endTime);
        require(registeredInDay[msg.sender] == 0);

        registeredInDay[msg.sender] = 1 + now.sub(startTime).div(24*60*60);
        participants.push(msg.sender);
        if (msg.value > 0) {
            // No money => No need to handle recirsive calls
            msg.sender.transfer(msg.value);
        }
    }

    // Owner methods

    function finalize() public onlyOwner {
        require(!finalized);
        require(now > endTime);

        finalized = true;
        Finalized();
    }

    function participantBonus(address participant) public constant returns(uint) {
        uint day = registeredInDay[participant];
        require(day > 0);

        uint bonus = 0;
        if (day <= 1) {
            bonus = 6;
        } else if (day <= 3) {
            bonus = 5;
        } else if (day <= 7) {
            bonus = 4;
        } else if (day <= 10) {
            bonus = 3;
        } else if (day <= 14) {
            bonus = 2;
        } else if (day <= 21) {
            bonus = 1;
        }

        return bonus.mul(bonusMultiplier);
    }

    function distribute(uint count) public onlyOwner {
        require(finalized && !distributed);
        require(count > 0 && distributedCount + count <= participants.length);
        
        for (uint i = 0; i < count; i++) {
            address participant = participants[distributedCount + i];
            uint256 bonus = participantBonus(participant);
            uint256 tokens = participant.balance.mul(TOKEN_RATE).mul(100 + bonus).div(100);
            token.mint(participant, tokens);
            distributedTokens += tokens;
        }
        distributedCount += count;

        if (distributedCount == participants.length) {
            uint256 ownerTokens = distributedTokens.mul(OWNER_TOKENS_PERCENT).div(100);
            token.mint(ownerWallet, ownerTokens);
            token.finishMinting();
            token.unpause();
            distributed = true;
            Distributed();
        }
    }

}