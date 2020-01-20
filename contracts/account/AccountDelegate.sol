pragma solidity 0.5.8;

import "./AccountStorage.sol";
import "./IAccountDelegate.sol";
import "./StorageStateful.sol";
import "../zeppelin-solidity/contracts/ownership/Ownable.sol";

/**
* 逻辑合约
*/
contract AccountDelegate is StorageStateful, Ownable, IAccountDelegate{
    
    modifier onlyAuthorized(bytes32 _name) {
        (bytes32 name, uint256 phone, address authorized, uint8 status) = _storage.search(_name);
        require(authorized == msg.sender, "AccountDelegate: must be Account authorized");
        _;
    }
    
    function register(bytes32 _name, uint256 _phone) external {
	    _storage.insert(_name, _phone, msg.sender, uint8(1));
	}
	
	function search(bytes32 _name) external view returns(bytes32, uint256, address, uint8){
		(bytes32 name, uint256 phone, address authorized, uint8 status) = _storage.search(_name);
		return (name, phone, authorized, status);
	}
	
	function updateInfo(bytes32 _name, uint256 _phone) external onlyAuthorized(_name){
	    _storage.update(_name, _phone, address(0), uint8(0));
	}
	
	function verify(bytes32 _name, uint8 _status) external onlyOwner {
	    require(_status != uint8(0), "_status can`t be zero");
	    _storage.update(_name, uint256(0), address(0), _status);
	}
	
	function isVerified(bytes32 _name) external view returns(bool) {
	    (,,,uint8 status) = _storage.search(_name);
	    bool isVer = status == uint8(3);
	    return isVer;
	}
	
	function getAuthorized(bytes32 _name) external view returns(address) {
	    (,,address authorized,) = _storage.search(_name);
	    return authorized;
	}
	
}
