var Clive = artifacts.require('Clive');

contract('Clive', function (accounts) {
  it("should set initial supply correctly", async () => {
    const token = await Clive.new();
    const initialSupply = await token.totalSupply();    
    assert.equal(initialSupply, 3000000, "Total supply was not well intialized");
  });
});
