# smart-contract-signing-and-recovery
How to sign a smart contract and recover the public key

A demonstration of how you can hash a message using keccac256, which converts it to a hex string.

firstly install eth-crypto tool with node (ensure node is installed) and run the following command.

```
npm install -g eth-crypto --save
```

Once this is installed, we'll use it to sign a message. you can use the signSomething.js file to allow eth-crypto do do four things:

1. Create a new identity, which will consist of the following three fake attributes:

e.g.

{
  address: "0x90f8bf6a349f320ead074411a4b0e7944ea8c9c1",
  privateKey: "0x4f3edf983ac236a65a842ce7c78d9aa706d3b113bce9c46f30d7d21715b23b1d",
  publicKey: "971a0b8bd54f7698b017b7785e77a5d7da2154ab5fab68644f8af9276edbec4fd001c57af2611fc58760992b7c4a575d6d1f6a875b68963dc868d06729efb2e5"
};


2. Hash a message - In the signSomething.js file example, we will hash two bits of information that forms the message:

[
  { type: "uint256", value: "5" },
  { type: "string", value: "Banana" }
]

Note the data formatting here which must be valid with Solidity (https://solidity.readthedocs.io/en/v0.4.24/types.html#value-types)

3. Sign the hashed message (using your address and private key)

4. Console.log (basically display on screen) the following three pieces of information:

- the hashed message
- the signature 
- the public key of the wallet


