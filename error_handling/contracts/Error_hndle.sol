pragma solidity ^0.5.1;

contract HasOwner{
    address internal owner;
    constructor() public{
        owner = msg.sender;
    }

    function useRequire() public view{
        require(msg.sender == owner,"error is caused by using require");
    }

    function useRevert() public pure{
        revert("error is caused by using revert");
    }

    function useAssert() public view{
        assert(msg.sender == owner);
    }
}

/*ERROR BY require()-
call to HasOwner.useRequire errored: VM error: revert.
revert	The transaction has been reverted to the initial state.
Reason provided by the contract: "error is caused by using require".
*/

/*ERROR BY revert()-
call to HasOwner.useRevert errored: VM error: revert.
revert	The transaction has been reverted to the initial state.
Reason provided by the contract: "error is caused by using revert".
*/



