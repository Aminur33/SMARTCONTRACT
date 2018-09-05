/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.24;
contract SimpleBet {

	address gameOwner = address(0);

	bool locked = false;

	function bet() payable
	{
		if ((random()%2==1) && (msg.value == 1 ether) && (!locked))
		{
			if (!msg.sender.call.value(2 ether)())
				throw;
		}
	}

	function lock()
	{
		if (gameOwner==msg.sender)
		{
			locked = true;
		}
	}

	function unlock()
	{
		if (gameOwner==msg.sender)
		{
			locked = false;
		}
	}

	function own(address owner)
	{
		if ((gameOwner == address(0)) || (gameOwner == msg.sender))
		{
			gameOwner = owner;
		}
	}

	function releaseFunds(uint amount)
	{
		if (gameOwner==msg.sender)
		{
			msg.sender.transfer( amount * (1 ether));
		}
	}


	function random() view returns (uint8) {
        	return uint8(uint256(keccak256(block.timestamp, block.difficulty))%256);
    	}

	function () public  payable
	{
		bet();
	}
}