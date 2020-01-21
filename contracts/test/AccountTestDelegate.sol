pragma solidity 0.5.8;

import "../account/IAccountDelegate.sol";

contract AccountTestDelegate{
	
	IAccountDelegate public ac;
	
	function setAc(IAccountDelegate _ac) external {
	    ac = _ac;
	}
	
	function register() external {
	    ac.register(bytes32("LJK"), uint256(18222109999));
	}
	
	function verify() external {
	    ac.verify(bytes32("LJK"), uint8(3));
	}
	
	function search() external view returns(bytes32, uint256, address, uint8){
	    return ac.search(bytes32("LJK"));
	}
}