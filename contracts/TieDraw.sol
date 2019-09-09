pragma solidity >=0.5.0 <0.6.0;
import "./ERC20.sol";

contract Game {
    address public banker;
    address public player;
    uint public betBalance;
    uint public result;
    uint public num1;
    uint public num2;

    function () external payable {}
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function playerBet(address _player, uint _betBalance) public {
        player = _player;
        betBalance = _betBalance;
    }

    function tieDraw() public payable {
        // require(_player == msg.sender);
        for (uint i = 0; i < 2; i++) {
            uint randNum = uint(keccak256(abi.encodePacked(now, msg.sender, i))) % 6;
            randNum = randNum + 1;
            if (i == 0) num1 = randNum;
            else num2 = randNum;
        }
        
        if (num1 == num2) {
            if (num1 == 6) result = 2;
            else result = 1;
        }
        else result = 0;
    }

    function withdrawTokens(address _tokenContract) onlyOwner public {
        require(result != 0);
        if(result == 1) {
            ERC20 token = ERC20(_tokenContract);
            uint tokenBalance = token.balanceOf(this);
            token.transfer(player, tokenBalance);
            WithdrewTokens(_tokenContract, msg.sender, tokenReward);
        }

        if(result == 2) {
            ERC20 token = ERC20(_tokenContract);
            uint tokenBalance = token.balanceOf(this);
            uint tokenReward = uint(tokenBalance) * uint(6)
            token.transfer(player, tokenReward);
            WithdrewTokens(_tokenContract, msg.sender, tokenReward);
        }
    }

    function info() public view returns(address, uint) {
        return(player, this.balance);
    }
}