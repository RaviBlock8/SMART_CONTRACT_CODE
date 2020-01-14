pragma solidity ^0.5.1;



contract erc{
    string public constant name = "Rether";
    string public constant symbol = "RE";
    //balances track tokens issued to each account
    mapping(address => uint256) public balances;
    //allowed is amount of tokens allowed to each acount to withdraw from another account
    mapping(address => mapping(address => uint256)) public allowed;
    uint256 totalsupply_;
    address internal towner;

    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );
    event Transfer(
        address indexed from,
        address indexed to,
        uint tokens
    );

    constructor(uint256 total) public{
        totalsupply_ = total;
        balances[msg.sender] = totalsupply_;
        towner = msg.sender;

    }

    function totalSupply() public view returns(uint256){
        return totalsupply_;
    }
    function balanceOf(address owner)public view returns(uint256){
        return balances[owner];
        //return balance[msg.sender];
    }
    function transfer(address reciever,uint256 numTokens) public payable returns(bool){
        require((msg.value / numTokens) == 2 ether,"give appropriate ether");
        require(numTokens <= balances[towner],"not sufficient tokens");
        balances[towner] = balances[towner]-numTokens;
        balances[reciever] = balances[reciever]+numTokens;
        emit Transfer(towner,reciever,numTokens);
        return true;
    }

    function approve(address delegate,uint numTokens) public returns(bool){
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender,delegate,numTokens);
        return true;
    }

    function allowance(address owner,address delegate) public view returns(uint){
        return allowed[owner][delegate];
    }

    function transferFrom(address owner,address delegate,uint numTokens) public returns(bool){
        require(numTokens<=balances[owner],"owner doesn't have enough tokens");
        require(numTokens<=allowed[owner][delegate],"tokens are not alloted");
        balances[owner] -= numTokens;
        allowed[owner][delegate] -= numTokens;
        balances[delegate] += numTokens;
        emit Transfer(owner,delegate,numTokens);
        return true;
    }


}