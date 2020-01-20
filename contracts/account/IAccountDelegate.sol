pragma solidity 0.5.8;

/**
* 接口合约
*/
interface IAccountDelegate {
    
    function register(bytes32 _name, uint256 _phone) external;
	
	function search(bytes32 _name) external view returns(bytes32, uint256, address, uint8);
	
	function updateInfo(bytes32 _name, uint256 _phone) external;
	
	function verify(bytes32 _name, uint8 _status) external;
	
	function isVerified(bytes32 _name) external view returns(bool);
	
	function getAuthorized(bytes32 _name) external view returns(address);
}
