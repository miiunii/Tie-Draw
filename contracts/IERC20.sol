pragma solidity ^0.4.18;

interface IERC20 {
  function balanceOf(address _owner) public view returns (uint256);
//   function allowance(address _owner, address _spender) public view returns (uint256);
  function transfer(address _to, uint256 _value) public returns (bool);
  function send1(address owner, address _to, uint256 _value) public returns (bool);
//   function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
//   function approve(address _spender, uint256 _value) public returns (bool);
  event Transfered(address indexed from, address indexed to, uint256 value);
//   event Approval(address indexed owner, address indexed spender, uint256 value);
}
