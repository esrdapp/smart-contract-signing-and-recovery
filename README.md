# smart-contract-signing-and-recovery
How to sign a smart contract and recover the public key

(Note this can also be done with this tool: https://app.mycrypto.com/sign-message)

Firstly install eth-crypto tool with node (ensure node is installed) and run the following command.

```
npm install -g eth-crypto --save
```

Once this is installed, we'll use it to sign a message. you can use the signSomething.js file to allow eth-crypto do do four things:

1. Create a new identity, which once created will consist of the following three attributes:

e.g.

```
{
  address: "0x90f8bf6a349f320ead074411a4b0e7944ea8c9c1",
  privateKey: "0x4f3edf983ac236a65a842ce7c78d9aa706d3b124cce9c46f30d7d21715b23b1d",
  publicKey: "971a0b8bd54f7698b017b7785e77a5d7da2154ab5fab68644f8af9276edbec4fd00124caf2611fc58760992b7c4a575d6d1f6a875b68963dc868d06729efb2e5"
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
hashed message: 0xc841e9c9424e154d06435d7a59c01135e9dab938da708d237dfbf24e92881436
signature: 0x75d0dbc28df8374b394822ac6b2327e0c524570933be0861692bac3075aa68273c3d14b3cb49985e1fe2f8d97c6e69bd622485f5eaa39d6f323920fc85a6212c1c
signer's private_key: 0x350cee6da5248e2a3637b06c227e05652fb32c203a14463930a816e2d91cc1a0
signer's public_key: 2dfb5e11707d86392879d704e2c2aaf247ce69845ce9d3f6a4738924efe75484814451094d87f57e864e35ecc5025d68170daa36e06be64122024bae8e8cba4b
signer's wallet_address: 0x6AEf0e32352E00b9E2c9Aa774E58DbCF06edaBD8
```

Now we have a signature to work with, let's deploy the Verify.sol smart contract in solidity wih Remix.
(if you don't know how to do this, read a guide on deploying smart contracts here: tbc)

Once deployed, paste the signature value into the "splitSignature" function call, and it will return three values:

0,1,2

these represent ECDSA v,r,s values

0 = v
1 = r
2 = s

You don't need to make note of these values, just be aware that when you are recovering the signer's address, this function is being called. 
You can read more about the significance of v,r,s values in ECDSA here - tbc

Ok so let's actually recover the signer's address, by using the "recoverAddress" function call.

You'll need both the hashed message value, and the signature value. Paste both values into the function call in Remix and it should output the signer's address!

You can also validate the string message that was hashed, which in the example signSomething.js file, was "Banana" (Note the quotes, and the capital B)

Use the "CheckIfDataIsValid" function call, and if it's valid, it will return true, proving the signer signed this message with the address. If any part of the string is wrong, for example changing the captial B to a lowercase b, then it will return false, proving the original message doesn't match the hash, and therefore is not the same signed message. 


