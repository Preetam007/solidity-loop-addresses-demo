pragma solidity^0.4.17;

contract Test {
    
    struct structUser {
        uint value;
        uint index;
        bool exists;
    }

    mapping(address => structUser) public arrayStructs;
    
    address[] public addressIndexes;
    
    function addAddress(uint _val) public returns (bool){
        // if user exists, add _val
        if (arrayStructs[msg.sender].exists > true) {
            arrayStructs[msg.sender].value += _val;
        }
        else {
            // else its new user
            addressIndexes.push(msg.sender);
            arrayStructs[msg.sender].value = _val;
            arrayStructs[msg.sender].index = addressIndexes.length-1;
            arrayStructs[msg.sender].exists = true;
        }
        return true;
    }
    
    function deleteAddress() public returns (bool) {
        // if address exists
        if (arrayStructs[msg.sender].exists) {
            structUser memory deletedUser = arrayStructs[msg.sender];
            // if index is not the last entry
            if (deletedUser.index != addressIndexes.length-1) {
                // delete indexed data
                delete arrayStructs[msg.sender];
                delete addressIndexes[deletedUser.index];
                // last strucUser
                address lastAddress = addressIndexes[addressIndexes.length-1];
                addressIndexes[deletedUser.index] = lastAddress;
                arrayStructs[lastAddress].index = deletedUser.index; 
                addressIndexes.length--;
            }
            // if index is last entry
            else {
               delete arrayStructs[msg.sender];
               addressIndexes.length--;
            }
            return true;
        }
    }
    
    function getAddresses() public view returns (address[]){
        return addressIndexes;    
    }
    
    function getTotalValue() public view returns (uint) {
        uint arrayLength = addressIndexes.length;
        uint total = 0;
        for (uint i=0; i<arrayLength; i++) {
            total += arrayStructs[addressIndexes[i]].value;
        }
        return total;
    }
    
    function getTotalUsers() public view returns (uint) {
        return addressIndexes.length;
    }
}
