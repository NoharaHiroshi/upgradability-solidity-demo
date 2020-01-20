pragma solidity 0.5.8;

import "../common/proxy.sol";
import "./StorageStateful.sol";
import "./AccountStorage.sol";

contract Account is StorageStateful, Proxy {
    
    bool public isInitialized;
	
	event UpdateStorage(address indexed admin, address indexed storage_);
	
	constructor() public {
		AccountStorage storage_ = new AccountStorage(address(this));
		_installStorage(storage_);
	}
	
	function _installGlobalS(KeyValueStorage globalS_) internal {
	    _globalS = globalS_;
	    _globalS.setAddress(keccak256("Account"), address(this));
	}
	
	function _installStorage(AccountStorage storage_) internal {
		_storage = storage_;
		emit UpdateStorage(msg.sender, address(storage_));
	}
	
	function initialize(KeyValueStorage globalS_, address logic_) onlyOwner external {
	    require(!isInitialized, "Account: has already initialized");
	    _installGlobalS(globalS_);
	    upgradeTo("0.0.1", logic_);
	    isInitialized = true;
	}
} 