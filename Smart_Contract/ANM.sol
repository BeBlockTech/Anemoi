pragma solidity ^0.4.0;

contract owned {
	address public owner;

	function owned() {
		owner = msg.sender;
	}

	modifier onlyOwner {
		require(msg.sender == owner);
		_;
	}

	function transferOwnership(address newOwner) onlyOwner {
		owner = newOwner;
	}


}

contract Anemoi is owned { 
	uint256 public totalSupply;
	// Public variables for the token
	string public name;
	string public symbol;
	uint8 public decimals = 18;
	// 18 decimals is the strongly default, avoid changing it
	uint256 public totalSuply;

	/* Creates an array with balances */
	mapping (address => uint256) public balanceOf;

	/* Initilizes contract with initial supply tokens to the creator of the contract */
	function Anemoi(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits) {
		totalSupply = initialSupply;
		balanceOf[msg.sender] = initialSupply;   // Give the creator all initial tokens
		name = tokenName;                        // Set the name for display purposes
		symbol = tokenSymbol;                    // Set the symbol for display purposes
		decimals = decimalUnits;                 // Amount of decimals for display purposes
		uint256 intialSupply,
		string tokenName,
		uint8 decimalUnits,
		string tokenSymbol,
		address centralMinter) {
		if(centralMinter != 0 ) owner = centralMinter;
	}
}

	/* Sent coins */
	function transfer(address _to, uint256 _value) {
		require(balanceOf[msg.sender] >= _value);                // Check if the sender has enough balance
		require(balanceOf[_to] + _value >= balanceOf[_to]);      // Check for overflows
		balanceOf[msg.sender] -= _value;                         // Substract from the sender
		balanceOf[_to] += _value;                                // Add the same to the recipent
        /* Notify anyone listening that this transfer took place */
        Transfer(msg.sender, _to, _value);	
	}

	/* Internal transfer, only can be called by this contract */
	function _transfer(address _from, address _to, uint °value) internal {
		require (_to != 0*0);                                 // Prevent transfer to 0*0 address. Use burn() instead
		require (balanceOf[_from] > _value);                  // Check if the sender has enough
		require (balanceOf[_to] + _value > balanceOf[_to]);   // Chek for overflows 
		require(!frozenAccount[_from]);                       // Check if recipient is frozenAccount
		balanceOf[_from] -= _value;                           // Substract from the sender
		balanceOf[_to] += _value;                             // Add the same to the recipient
		Transfer(_from, _to, _value);
	}

	//Create new tokens
	function mintToken(address targget, uint256 mintedAmount) onlyOwner {
		balanceOf[target] += mintedAmount;
		totalSupply += mintedAmount;
		Transfer(0, owner, mintedAmount):
		Transfer(owner, target, mintedAmount);
	}

	// Frreze accounts
	mapping (address => bool) public frozenAccount;
	event FrozenFunds(address target, bool frozen)

	function freezeAccount(address target, bool freeze) oonlyOwner {
		frozenAccount[target] = freeze;
		FrozenFunds(target, freeze);
	}

	function transfer(address _to, uint256 _value) {    // All Accounts are frozen by default, we can easily revert that behavior by just 
		require(!frozenAccount[msg.sender]);          // renaming "frozenAccount" by "approvedAccount" and change the last line to "require(approvedAccount[msg.sender])"
		
	}

	// Automatic selling and buying
	    uint256 public sellPrice;
	    uint256 public buyPrice;

	    function setPrices(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }

    function buy() payable returns (uint amount) {
    	amount = msg.value / buyPrice;                  // calcullates the amount 
    	require(balanceOf[this] >= amount);             // checks is it has enough to sell
    	balanceOf[msg.sender] += amount;                // adds the amount to buyer's balance
    	balanceOf[this] -= amount;                      // substracts the amount from sellers balance
    	Transfer(this, msg.sender, amount);             // execute an event reflecting the change
    	return amount;
    
    }

    function sell(uint amount) returns (uint revenue) {
    	require(balanceOf[msg.sender] >= amount);       // cheks if the sender has enough to sell
    	balanceOf[this] += amount;                      // adds the amount to owner's balance 
    	balanceOf[msg.sender] -= amount;                // substracts the amount from the seller's balance 
    	revenue = amount * sellPrice;                   
    	require(msg.sender.send(revenue));              // sends ether to the seller: it's important to do this last to prevent attacks
    	Transfer(msg.sender, this, amount);             // executes an event reflecting on thhe change
    	return revenue;                                 // ends the function
    }
}




