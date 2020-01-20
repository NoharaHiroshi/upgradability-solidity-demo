pragma solidity 0.5.8;

import "./AccountStorage.sol";
import "../common/KeyValueStorage.sol";

// 键值存储
contract StorageStateful {
    AccountStorage public _storage;
    KeyValueStorage public _globalS;
}
