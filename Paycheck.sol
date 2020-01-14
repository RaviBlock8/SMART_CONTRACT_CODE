pragma solidity ^0.5.1;

contract Paycheck{
    uint amountAdded;
    address[] internal emp;
    
    address payable wallet;
    mapping(address => uint) internal withdrawn;

    constructor(address payable _wallet) public payable{
        wallet = _wallet;
    }

    modifier onlyMembers{
        bool con;
        for(uint i = 0;i<emp.length;i++){
            if(msg.sender == emp[i]){
                con = true;
            }
        }
        require(con,"not an employee");
        _;

    }
    function addMoney()public payable{
        wallet.transfer(1);
        amountAdded = msg.value-1;
        bool con;
        for(uint i=0;i<emp.length;i++){
            if(msg.sender==emp[i]){
                con=true;
            }
        }
        if(con==false){
            emp.push(msg.sender);
        }
    }

    function withdraw(uint amt) public onlyMembers{
        uint amtAllt = amountAdded/emp.length;
        uint allwd = amtAllt-withdrawn[msg.sender];
        if(amt<=allwd){
            msg.sender.transfer(amt);
        }



    }
}