// SPDX-License-Identifier: UNLICENSED

/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
A simple smart contract that is used to return the v,r,s values (0,1,2) by splitting up a supplied signature, 
using the "splitSignature" function call.
You can also recover a signer (wallet address) using the "recoverSigner" function call, providing you can 
supply a hash of the message (hashed with keccac256), and the message signature
An Ethereum (or Bitcoin) address is essentially a hashed version of the public key. 
If you have a public key, you can hash it, and you'll have a wallet address.
Remember, public keys can be created using private keys; however, you CANNOT create Private keys from Public keys. 
(Public key generation is a ONE-WAY function)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/

pragma solidity ^0.8.0;
contract Verify {


   function checkIfDataIsValid(string memory textString, bytes memory signature, address publicKey) public pure returns(address, bool){
       bytes32 message = keccak256(abi.encodePacked(textString));
       return (publicKey, (recoverPublicKey(message, signature) == publicKey));
   }


   function recoverPublicKey(bytes32 hashedMessage, bytes memory signature) public pure returns (address){
       uint8 v;
       bytes32 r;
       bytes32 s;
       (v, r, s) = splitSignatureIntoVRS(signature);
       return ecrecover(hashedMessage, v, r, s);
   }


   function splitSignatureIntoVRS(bytes memory signature) public pure returns (uint8, bytes32, bytes32){
       require(signature.length == 65);
       bytes32 r;
       bytes32 s;
       uint8 v;
       assembly {
           // first 32 bytes, after the length prefix
           r := mload(add(signature, 32))
           // second 32 bytes
           s := mload(add(signature, 64))
           // final byte (first byte of the next 32 bytes)
           v := byte(0, mload(add(signature, 96)))
       }
       
       // return as v=0, r=1, s=2 
       return (v, r, s);
   }

}
