// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Target {
   uint256 public number;
   string public admin = "Amir La Ode";

  
   

   function setNumber(uint256 _NewNumber) public returns(uint) {
     number = _NewNumber;
     return number;
   }

   function getAdmin() public view returns (string memory) {
     return admin;
   }

   function addNumbers ( uint256 _Num1, uint256 _Num2) public pure returns (uint256) {
     return _Num1 + _Num2;
   }
}



contract Caller {
    // ** Tujuan : Menerapkan Call, StaticCall, dan DelegateCall

    // * Call : mengubah angka di kontrak target
    uint public targetNumber;
    string public targetAdmin;
    uint public sum;

   function setTargetNumber(address _Address, uint256 _Number)  public {
    (bool success, bytes memory data) = _Address.call(abi.encodeWithSignature("setNumber(uint256)", _Number));
    require(success, "Call Revert");
    targetNumber = abi.decode(data, (uint256));
    
    }


    // * StaticCall : Melihat data target tanpa mengubah apapun

    function getTargetAdmin(address _Address) public returns(string memory) {
        (bool success, bytes memory data) = _Address.staticcall(abi.encodeWithSignature("getAdmin()"));
        require(success, "StaticCall Revert");
        targetAdmin = abi.decode(data,(string));
        return targetAdmin;
        
    }

    // * DelegateCall : Menghitung operasi matematika dengan meminjam fungsi di kontrak trarget

    function addNumbersss(address _Address, uint256 _Number1, uint256 _Number2) public returns(uint) {
        (bool success, bytes memory data) = _Address.delegatecall(abi.encodeWithSignature("addNumbers(uint256,uint256)",_Number1,_Number2));
        require(success, "DelegateCall Revert");
        sum = abi.decode(data,(uint256));
        return sum;
    }


}