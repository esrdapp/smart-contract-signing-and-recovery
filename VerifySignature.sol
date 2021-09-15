/*
A simple smart contract that is used to return the v,r,s values (0,1,2) by splitting up a supplied signature, 
using the "splitSignature" function call.

You can also recover a signer (wallet address) using the "recoverSigner" function call, providing you can 
supply a hash of the message (hashed with keccac256), and the message signature

An Ethereum (or Bitcoin) address is essentially a hashed version of the public key. 
If you have a public key, you can hash it, and you'll have a wallet address.

Remember, public keys can be created using private keys; however, you CANNOT create Private keys from Public keys. 
(Public key generation is a ONE-WAY function)
*/

pragma solidity ^0.5.0;
contract Verify { 

  function recoverSigner(bytes32 message, bytes memory sig)
       public
       pure
       returns (address)
    {
       uint8 v;
       bytes32 r;
       bytes32 s;

       (v, r, s) = splitSignature(sig);
       return ecrecover(message, v, r, s);
  }

  function splitSignature(bytes memory sig)
       public
       pure
       returns (uint8, bytes32, bytes32)
   {
       require(sig.length == 65);
       
       bytes32 r;
       bytes32 s;
       uint8 v;

       assembly {
           // first 32 bytes, after the length prefix
           r := mload(add(sig, 32))
           // second 32 bytes
           s := mload(add(sig, 64))
           // final byte (first byte of the next 32 bytes)
           v := byte(0, mload(add(sig, 96)))
       }

       return (v, r, s);
   }
}
