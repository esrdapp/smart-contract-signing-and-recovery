# smart-contract-signing-and-recovery
How to sign a smart contract and recover the public key

(Note this can also be done with this tool: https://app.mycrypto.com/sign-message)

A demonstration of how you can hash a message using keccac256, which converts it to a hex string.

firstly install eth-crypto tool with node (ensure node is installed) and run the following command.

```
npm install -g eth-crypto --save
```

Once this is installed, we'll use it to sign a message. you can use the signSomething.js file to allow eth-crypto do do four things:

1. Create a new identity, which once created will consist of the following three attributes:

e.g.

```
{
  address: "0x90f8bf6a349f320ead074411a4b0e7944ea8c9c1",
  privateKey: "0x4f3edf983ac236a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d",
  publicKey: "971a0b8bd54f7698b017b7785e77a5d7da2154ab5fab68644f8af9276edbec4fd001c57af2611fc58760992b7c4a575d6d1f6a875b68963dc868d06729efb2e5"
};
```

2. Hash a message - In the signSomething.js file example, we will hash two bits of information that forms the message:

```
[
  { type: "string", value: "Banana" }
]
```

Note the data formatting here which must be valid with Solidity (https://solidity.readthedocs.io/en/v0.4.24/types.html#value-types)

3. Sign the hashed message (using your address and private key)

4. Console.log (basically display on screen) the following three pieces of information:

- the hash of the message
- the signature 
- the public key of the wallet address (Note: To make an address from a public key, all you need to do is apply Keccak-256 to the key, and then take the last 20 bytes of the result. And that’s it.

Let's run our signSomething.js file with node to do these steps:

``
node signSomething.js
```

You should see something similar to this:

```
C:\Users\PC\Desktop\signer>node signSomething.js
secp256k1 unavailable, reverting to browser version
message: 0x97c943890b15f4dea02c3ae1653252489599957b280a95bf2e533fdbc8facb58
signature: 0x43125ece782a09443c7bd2f42df837021dc5b72e03881bcd7c4c559f51ee3a3836427174942a6906f296d6456342b3c7b8497905931e4c9cf3b0a20c458c2bd51b
signer public key: 0xbC2771BcEb3ee8E050B14Ae4ee5dCf303DFfA1eD
```

Now we have a signature to work with, let's deploy the Verify.sol smart contract in solidity wih Remix.
(if you don't know how to do this, read a guide on deploying smart contracts here: tbc)

Once deployed, paste the signature value into the "splitSignature" function call, and it will return three values:

0,1,2

these represent ECDSA v,r,s values

0 = v
1 = r
2 = s

You don't need to make note of these values, just be aware that when you are recovering the public key, this function is being called. 
You can read more about the significance of v,r,s values in ECDSA here - tbc

Ok so let's actually recover the public key, by using the "recoverPublicKey" function call.

You'll need both the hashed message value, and the signature value. Paste both values into the function call in Remix and it should output your public key!

You can also validate the string message that was hashed, which in the example signSomething.js file, was "Banana" (Note the quotes, and the capital B)

Use the "CheckIfDataIsValid" function call, and if it's valid, it will return true, proving the signer signed this message!


