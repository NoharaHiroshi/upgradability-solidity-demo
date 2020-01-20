pragma solidity 0.5.8;

import "../interface/IOwnable.sol";

/**
 * @title 数据存储，以Key-Value形式存储数据，Key统一为bytes32格式
 */
contract KeyValueStorage {
    
    address public admin;
	
	mapping (bytes32 => uint256) internal uintData;
    mapping (bytes32 => bytes32) internal bytes32Data;
    mapping (bytes32 => address) internal addressData;
    mapping (bytes32 => string) internal stringData;
    mapping (bytes32 => bytes) internal bytesData;
    mapping (bytes32 => bool) internal boolData;
    mapping (bytes32 => uint256[]) internal uintArrayData;
    mapping (bytes32 => bytes32[]) internal bytes32ArrayData;
    mapping (bytes32 => address[]) internal addressArrayData;
    mapping (bytes32 => bool[]) internal boolArrayData;
    
    constructor() public {
        admin = msg.sender;
    }
	
	// 写成func, 节省gas消耗
	function _isAuthorized() view internal {
        require(IOwnable(msg.sender).owner() == admin, "KeyValueStorage: Unauthorized");
    }
	
	// 校验key是否有效
    modifier validKey(bytes32 _key) {
        require(_key != bytes32(0), "bad key");
        _;
    }

	// 验证键值数组长度是否匹配
    modifier validArrayLength(uint256 _keyLength, uint256 _dataLength) {
        require(_keyLength == _dataLength, "bad length");
        _;
    }
	
	//////////////////
    //// Insert
    //////////////////
    function insertUint256(bytes32 _key, uint256 _data)  external {
		_isAuthorized();
        _setData(_key, _data, true);
    }

    function insertBytes32(bytes32 _key, bytes32 _data)  external {
		_isAuthorized();
        _setData(_key, _data, true);
    }

    function insertAddress(bytes32 _key, address _data)  external {
		_isAuthorized();
        _setData(_key, _data, true);
    }

    function insertBool(bytes32 _key, bool _data)  external {
		_isAuthorized();
        _setData(_key, _data, true);
    }

    //////////////////
    //// Set
    //////////////////
    function setUint256(bytes32 _key, uint256 _data)  external {
		_isAuthorized();
        _setData(_key, _data, false);
    }

    function setBytes32(bytes32 _key, bytes32 _data)  external {
		_isAuthorized();
        _setData(_key, _data, false);
    }

    function setAddress(bytes32 _key, address _data)  external {
		_isAuthorized();
        _setData(_key, _data, false);
    }

    function setBool(bytes32 _key, bool _data)  external {
		_isAuthorized();
        _setData(_key, _data, false);
    }

    function setString(bytes32 _key, string calldata _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

    function setBytes(bytes32 _key, bytes calldata _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

	//////////////////
    //// Set Array
    //////////////////
    function setUint256Array(bytes32 _key, uint256[] calldata  _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

    function setBytes32Array(bytes32 _key, bytes32[] calldata _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

    function setAddressArray(bytes32 _key, address[] calldata  _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

    function setBoolArray(bytes32 _key, bool[] calldata  _data)  external {
		_isAuthorized();
        _setData(_key, _data);
    }

	//////////////////
    //// Delete
    //////////////////
    function deleteUint256(bytes32 _key, uint256 _index)  external {
		_isAuthorized();
        _deleteUint(_key, _index);
    }

    function deleteBytes32(bytes32 _key, uint256 _index)  external {
		_isAuthorized();
        _deleteBytes32(_key, _index);
    }

    function deleteAddress(bytes32 _key, uint256 _index)  external {
		_isAuthorized();
        _deleteAddress(_key, _index);
    }

    function deleteBool(bytes32 _key, uint256 _index)  external {
		_isAuthorized();
        _deleteBool(_key, _index);
    }
	
	//////////////////
    //// Multi Insert
    //////////////////
    function insertUint256Multi(bytes32[] memory _keys, uint256[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], true);
        }
    }

    function insertBytes32Multi(bytes32[] memory _keys, bytes32[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], true);
        }
    }

    function insertAddressMulti(bytes32[] memory _keys, address[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], true);
        }
    }

    function insertBoolMulti(bytes32[] memory _keys, bool[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], true);
        }
    }

    //////////////////
    //// Multi Set
    //////////////////
    function setUint256Multi(bytes32[] memory _keys, uint256[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], false);
        }
    }

    function setBytes32Multi(bytes32[] memory _keys, bytes32[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], false);
        }
    }

    function setAddressMulti(bytes32[] memory _keys, address[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], false);
        }
    }

    function setBoolMulti(bytes32[] memory _keys, bool[] memory _data) public  validArrayLength(_keys.length, _data.length) {
		_isAuthorized();
        for (uint256 i = 0; i < _keys.length; i++) {
            _setData(_keys[i], _data[i], false);
        }
    }
	
	//////////////////
    //// Get
    //////////////////
    function getUint256(bytes32 _key) external view returns(uint256) {
        return uintData[_key];
    }

    function getBytes32(bytes32 _key) external view returns(bytes32) {
        return bytes32Data[_key];
    }

    function getAddress(bytes32 _key) external view returns(address) {
        return addressData[_key];
    }

    function getString(bytes32 _key) external view returns(string memory) {
        return stringData[_key];
    }

    function getBytes(bytes32 _key) external view returns(bytes memory) {
        return bytesData[_key];
    }

    function getBool(bytes32 _key) external view returns(bool) {
        return boolData[_key];
    }


	//////////////////
    //// Get Array
    //////////////////
    function getUint256Array(bytes32 _key) external view returns(uint256[] memory) {
        return uintArrayData[_key];
    }

    function getBytes32Array(bytes32 _key) external view returns(bytes32[] memory) {
        return bytes32ArrayData[_key];
    }

    function getAddressArray(bytes32 _key) external view returns(address[] memory) {
        return addressArrayData[_key];
    }

    function getBoolArray(bytes32 _key) external view returns(bool[] memory) {
        return boolArrayData[_key];
    }


	//////////////////
    //// Get Array Length
    //////////////////
    function getUint256ArrayLength(bytes32 _key) external view returns(uint256) {
        return uintArrayData[_key].length;
    }

    function getBytes32ArrayLength(bytes32 _key) external view returns(uint256) {
        return bytes32ArrayData[_key].length;
    }

    function getAddressArrayLength(bytes32 _key) external view returns(uint256) {
        return addressArrayData[_key].length;
    }

    function getBoolArrayLength(bytes32 _key) external view returns(uint256) {
        return boolArrayData[_key].length;
    }


	//////////////////
    //// Get Array Element
    //////////////////
    function getUint256ArrayElement(bytes32 _key, uint256 _index) external view returns(uint256) {
        return uintArrayData[_key][_index];
    }

    function getBytes32ArrayElement(bytes32 _key, uint256 _index) external view returns(bytes32) {
        return bytes32ArrayData[_key][_index];
    }

    function getAddressArrayElement(bytes32 _key, uint256 _index) external view returns(address) {
        return addressArrayData[_key][_index];
    }

    function getBoolArrayElement(bytes32 _key, uint256 _index) external view returns(bool) {
        return boolArrayData[_key][_index];
    }

	//////////////////
    //// Get Array Elements
    //////////////////
    function getUint256ArrayElements(bytes32 _key, uint256 _startIndex, uint256 _endIndex) public view returns(uint256[] memory array) {
        uint256 size = uintArrayData[_key].length;
        if (_endIndex >= size) {
            size = size - _startIndex;
        } else {
            size = _endIndex - _startIndex + 1;
        }
        array = new uint256[](size);
        for(uint256 i; i < size; i++)
            array[i] = uintArrayData[_key][i + _startIndex];
    }

    function getBytes32ArrayElements(bytes32 _key, uint256 _startIndex, uint256 _endIndex) public view returns(bytes32[] memory array) {
        uint256 size = bytes32ArrayData[_key].length;
        if (_endIndex >= size) {
            size = size - _startIndex;
        } else {
            size = _endIndex - _startIndex + 1;
        }
        array = new bytes32[](size);
        for(uint256 i; i < size; i++)
            array[i] = bytes32ArrayData[_key][i + _startIndex];
    }

    function getAddressArrayElements(bytes32 _key, uint256 _startIndex, uint256 _endIndex) public view returns(address[] memory array) {
        uint256 size = addressArrayData[_key].length;
        if (_endIndex >= size) {
            size = size - _startIndex;
        } else {
            size = _endIndex - _startIndex + 1;
        }
        array = new address[](size);
        for(uint256 i; i < size; i++)
            array[i] = addressArrayData[_key][i + _startIndex];
    }

    function getBoolArrayElements(bytes32 _key, uint256 _startIndex, uint256 _endIndex) public view returns(bool[] memory array) {
        uint256 size = boolArrayData[_key].length;
        if (_endIndex >= size) {
            size = size - _startIndex;
        } else {
            size = _endIndex - _startIndex + 1;
        }
        array = new bool[](size);
        for(uint256 i; i < size; i++)
            array[i] = boolArrayData[_key][i + _startIndex];
    }

	//////////////////
    //// Internal _setData
    //////////////////
    function _setData(bytes32 _key, uint256 _data, bool _insert) internal validKey(_key) {
        if (_insert)
            uintArrayData[_key].push(_data);
        else
            uintData[_key] = _data;
    }

    function _setData(bytes32 _key, bytes32 _data, bool _insert) internal validKey(_key) {
        if (_insert)
            bytes32ArrayData[_key].push(_data);
        else
            bytes32Data[_key] = _data;
    }

    function _setData(bytes32 _key, address _data, bool _insert) internal validKey(_key) {
        if (_insert)
            addressArrayData[_key].push(_data);
        else
            addressData[_key] = _data;
    }

    function _setData(bytes32 _key, bool _data, bool _insert) internal validKey(_key) {
        if (_insert)
            boolArrayData[_key].push(_data);
        else
            boolData[_key] = _data;
    }

    function _setData(bytes32 _key, string memory _data) internal validKey(_key) {
        stringData[_key] = _data;
    }

    function _setData(bytes32 _key, bytes memory _data) internal validKey(_key) {
        bytesData[_key] = _data;
    }

    function _setData(bytes32 _key, uint256[] memory _data) internal validKey(_key) {
        uintArrayData[_key] = _data;
    }

    function _setData(bytes32 _key, bytes32[] memory _data) internal validKey(_key) {
        bytes32ArrayData[_key] = _data;
    }

    function _setData(bytes32 _key, address[] memory _data) internal validKey(_key) {
        addressArrayData[_key] = _data;
    }

    function _setData(bytes32 _key, bool[] memory _data) internal validKey(_key) {
        boolArrayData[_key] = _data;
    }

	//////////////////
    //// Internal _delete
    //////////////////
    function _deleteUint(bytes32 _key, uint256 _index) internal validKey(_key) {
        require(uintArrayData[_key].length > _index, "Invalid Index"); //Also prevents undeflow
        uintArrayData[_key][_index] = uintArrayData[_key][uintArrayData[_key].length - 1];
        uintArrayData[_key].length--;
    }

    function _deleteBytes32(bytes32 _key, uint256 _index) internal validKey(_key) {
        require(bytes32ArrayData[_key].length > _index, "Invalid Index"); //Also prevents undeflow
        bytes32ArrayData[_key][_index] = bytes32ArrayData[_key][bytes32ArrayData[_key].length - 1];
        bytes32ArrayData[_key].length--;
    }

    function _deleteAddress(bytes32 _key, uint256 _index) internal validKey(_key) {
        require(addressArrayData[_key].length > _index, "Invalid Index"); //Also prevents undeflow
        addressArrayData[_key][_index] = addressArrayData[_key][addressArrayData[_key].length - 1];
        addressArrayData[_key].length--;
    }

    function _deleteBool(bytes32 _key, uint256 _index) internal validKey(_key) {
        require(boolArrayData[_key].length > _index, "Invalid Index"); //Also prevents undeflow
        boolArrayData[_key][_index] = boolArrayData[_key][boolArrayData[_key].length - 1];
        boolArrayData[_key].length--;
    }
}
