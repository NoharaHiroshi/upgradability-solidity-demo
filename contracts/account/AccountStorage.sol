pragma solidity 0.5.8;

contract AccountStorage {
	
	address public proxy;
	
	struct Account {
		bytes32 name;     		// 客户名（主键）
		uint256 phone;			// 手机号
		address authorized;		// 所有者
		uint8 status;			// 状态
	}
	
	mapping (bytes32 => Account) public Accounts;
	mapping (bytes32 => uint256) public AccountIndex;
	
	// 客户列表
	bytes32[] public AccountNames;
	
 	constructor(address _proxy) public {
        require(_proxy != address(0), "zero address is not allowed");
        proxy = _proxy;
    }
	
	// 验证对model的操作是否来源于Proxy, 写成func, 节省gas消耗
 	function _isAuthorized() view internal {
         require(msg.sender == proxy, "AccountStorage: must be proxy");
     }
	
	function _checkParam(bytes32 _name, uint256 _phone, address _addr, uint8 _status) pure internal {
		require(_name != bytes32(0), "AccountStorage: _name null is not allowed");
		require(_phone != uint256(0), "AccountStorage: _phone null is not allowed");
		require(_addr != address(0), "AccountStorage: _addr null is not allowed");
		require(_status != uint8(0), "AccountStorage: _status null is not allowed");
	}
	
	function _insert(bytes32 _name, uint256 _phone, address _addr, uint8 _status) internal {
		_checkParam(_name, _phone, _addr, _status);
		
		require(Accounts[_name].name == bytes32(0), "AccountStorage: current Account exist");
 		Account memory a = Account(_name, _phone, _addr, _status);
        Accounts[_name] = a;
		
		AccountNames.push(_name);
		AccountIndex[_name] = AccountNames.length;
	}
	
	function insert(bytes32 _name, uint256 _phone, address _addr, uint8 _status) external{
		_isAuthorized();
		_insert(_name, _phone, _addr, _status);
	}
	
	function _update(bytes32 _name, uint256 _phone, address _addr, uint8 _status) internal {
		require(_name != bytes32(0), "AccountStorage: _name null is not allowed");
		require(Accounts[_name].name != bytes32(0), "AccountStorage: current Account not exist");
		
		Account memory a = Accounts[_name];
		if(_phone != uint256(0)){
			a.phone = _phone;
		}
		if(_addr != address(0)){
			a.authorized = _addr;
		}
		if(_status != uint8(0)){
			a.status = _status;
		}
		Accounts[_name] = a;
	}
	
	function update(bytes32 _name, uint256 _phone, address _addr, uint8 _status) external {
		_isAuthorized();
		_update(_name, _phone, _addr, _status);
	}
	
	function _search(bytes32 _name) internal view  returns(bytes32, uint256, address, uint8) {
		require(_name != bytes32(0), "AccountStorage: _name null is not allowed");
		require(Accounts[_name].name != bytes32(0), "AccountStorage: current Account not exist");
		
		Account memory a = Accounts[_name];
		return (a.name, a.phone, a.authorized, a.status);
	}
	
	function search(bytes32 _name) external view returns(bytes32, uint256, address, uint8) {
		_isAuthorized();
		return _search(_name);
	}
	
	function _delete(bytes32 _name) internal {
		require(_name != bytes32(0), "AccountStorage: _name null is not allowed");
		require(Accounts[_name].name != bytes32(0), "AccountStorage: current Account not exist");
		
		uint256 _deleteIndex = AccountIndex[_name] - 1;
		uint256 _lastIndex = AccountNames.length - 1;
		if(_deleteIndex != _lastIndex){
			AccountNames[_deleteIndex] = AccountNames[_lastIndex];
			AccountIndex[AccountNames[_lastIndex]] = _deleteIndex + 1;
		}
		AccountNames.length--;
		delete AccountIndex[_name];
		delete Accounts[_name];
	}
	
	function del(bytes32 _name) external {
		_isAuthorized();
		_delete(_name);
	}
    
}