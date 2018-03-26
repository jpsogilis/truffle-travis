var Clive = artifacts.require('CliveMock');

contract('Clive', function (accounts) {
  it("should set initial supply correctly", async () => {
    const token = await Clive.new(accounts[0], 3000000);
    const initialSupply = await token.totalSupply();    
    assert.equal(initialSupply, 3000000, "Total supply was not well intialized");
  });
});
