pragma solidity 0.5.8;

import "../common/KeyValueStorage.sol";
import "../account/IAccountDelegate.sol";
import "../libraries/Util.sol";
import "../zeppelin-solidity/contracts/ownership/Ownable.sol";

contract ERC20 is Ownable {
    string public name; 				
    string public symbol; 				
    uint8 public decimals = 2;  		
    uint256 public totalSupply;
    KeyValueStorage public globalS;

    mapping (address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(uint256 initialSupply, string memory tokenName, string memory tokenSymbol, KeyValueStorage globalStorage) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);  
        balanceOf[msg.sender] = totalSupply;                
        name = tokenName;                                    
        symbol = tokenSymbol;         
        globalS = globalStorage;
    }
    
    function _account() internal view returns(IAccountDelegate) {
        IAccountDelegate ia = IAccountDelegate(globalS.getAddress(keccak256("Account")));
        return ia;
    }

    function _transfer(address _from, address _to, uint _value) internal {
	
		if(_from != _to){	
			require(_to != address(0));
			require(balanceOf[_from] >= _value);
			require(balanceOf[_to] + _value > balanceOf[_to]);

			uint previousBalances = balanceOf[_from] + balanceOf[_to];
			balanceOf[_from] -= _value;
			balanceOf[_to] += _value;
			emit Transfer(_from, _to, _value);
			assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
		}
    }

    /**
     *  代币交易转移，只能向通过认证的客户发放Token
     */
    function transfer(string memory _name, uint256 _value) public {
        bytes32 name_ = Util.stringToBytes32(_name);
        IAccountDelegate ia = _account();
        require(ia.isVerified(name_), "ERC20: current account not verified");
        address _to = ia.getAuthorized(name_);
        _transfer(msg.sender, _to, _value);
    }

}