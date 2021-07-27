const { expect } = require("chai");

describe("Toffy", function () {
  it("Should mint supply once", async function () {
    const Toffy = await ethers.getContractFactory("ToffyToken");
    const toffy = await Toffy.deploy();
    await toffy.deployed();
    await toffy.mint(10000).catch(e => e)

    // duplicate mint
    await toffy.mint(10000).catch(e => e)

    const supply = await toffy.totalSupply()

    expect(supply.toNumber()).to.equal(10000);

  });
});
