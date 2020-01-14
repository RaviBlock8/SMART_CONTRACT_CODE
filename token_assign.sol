pragma solidity ^0.5.1;

contract Token{
    mapping(address=>uint) public balances;
    address payable wallet;
    address internal owner;
    uint public total;
    constructor(address payable _wallet) public {
        wallet = _wallet;
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner,"not an owner");
        _;
    }

    function buyToken() public payable{
        balances[msg.sender] += 1;
        total += msg.value;

    }

    function withdraw() public onlyOwner{
        if(total>50){
            wallet.transfer(total);
        }
    }

}