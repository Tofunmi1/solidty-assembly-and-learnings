import { Asm__factory } from "./types/ethers-contracts";
import { ethers } from "ethers";

const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:8545/");
const signer = provider.getSigner();
const contract = Asm__factory.connect(
  "0x5fbdb2315678afecb367f032d93f642f64180aa3",
  signer
);

const run = async (): Promise<ethers.BigNumber> => {
  const sumofArray = await contract.asmSumOfArray([1, 1, 2, 3]);
  console.log(sumofArray);
  return sumofArray;
};

run().catch((err) => console.error(err));
