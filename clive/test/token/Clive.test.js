var assertRevert = require('../assertRevert').assertRevert;
var Clive = artifacts.require('CliveMock');

contract('Clive', function ([owner, recipient, anotherAccount]) {
  const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000';

  beforeEach(async function () {
    this.token = await Clive.new(owner, 3000000);
  });

  describe('[Function] totalSupply():', function () {
    describe('initialSupply is 3000000.', function () {
      it("should set initial supply correctly.", async function () {
        const initialSupply = await this.token.totalSupply();    
        assert.equal(Number(initialSupply), 3000000, "Total supply was not well intialized.");
      });
    });
  });
  describe('[Function] balanceOf():', function () {
    describe('- When the requested account has no tokens:', function () {
      it('Requested account amount is null.', async function () {
        const balance = await this.token.balanceOf(anotherAccount);
        assert.equal(Number(balance), 0, "Requested account have tokens whereas he was supposed to be null");
      });
    });

    describe('- When the requested account has some tokens:', function () {
      it('Requested account amount equal to total amount of tokens.', async function () {
        const balance = await this.token.balanceOf(owner);
        assert.equal(Number(balance), 3000000, "Requested account amount is not equal to total amount of tokens.");
      });
    });
  });
  describe('[Function] transfer():', function () {
    describe('- When the recipient is not the zero address:', function () {
      const to = recipient;

      describe('# When the sender does not have enough balance:', function () {
        const amount = 3000001;
        it('Clive transfer failed.', async function () {
          await assertRevert(this.token.transfer(to, amount, { from: owner }));
        });
      });

      describe('# When the sender has enough balance:', function () {
        const amount = 1000000;

	describe('-> Owner sends 1000000 to recipient account.', function () {
          it('[LOG1] Transfer amount correctly.', async function () {
            const { logs } = await this.token.transfer(to, amount, { from: owner });
            
            const senderBalance = await this.token.balanceOf(owner);
            const recipientBalance = await this.token.balanceOf(to);

            assert.equal(Number(senderBalance), 2000000, 'Sender does not debit amount ('+amount+' Clives).');
            assert.equal(Number(recipientBalance), amount, 'Sender does not debit amount ('+amount+' Clives).');
            console.log("\t      [LOG1] Anchored data in BlockChain =>"+"\n"+"\t\t\t\t\t{\n\
                                           owner balance = "+senderBalance+",\n\
                                           recipient balance = "+recipientBalance+",\n\
                                           amount = "+logs[0].args.value+" Clives\n\t\t\t\t\t}");

          });
	});

        it('[LOG2] Emits a transfer event.', async function () {
          const { logs } = await this.token.transfer(to, amount, { from: owner });

          assert.equal(logs.length, 1);
          assert.equal(logs[0].event, 'Transfer');
          assert.equal(logs[0].args.from, owner);
          assert.equal(logs[0].args.to, to);
          assert(logs[0].args.value.eq(amount));
          console.log("\t    [LOG2] Anchored data in BlockChain =>"+"\n"+"\t\t\t\t\t{\n\
                                           event = "+logs[0].event+",\n\
                                           owner address = "+logs[0].args.from+",\n\
                                           recipient address = "+logs[0].args.to+",\n\
                                           amount = "+logs[0].args.value+" Clives\n\t\t\t\t\t}");


        });
      });
    });
  });
  describe('- When the recipient is the zero address:', function () {
    const to = ZERO_ADDRESS;

    it('Clives transfer failed.', async function () {
      await assertRevert(this.token.transfer(to, 100, { from: owner }));
    });
  });
  describe('[Function] burn()', function () {
    const from = owner;

    describe('- When the given amount is not greater than balance of the sender:', function () {
      const amount = 1000000;

      it('Burns the requested amount (1000000 Clives).', async function () {
        await this.token.burn(amount, { from });

        const balance = await this.token.balanceOf(from);
        assert.equal(Number(balance), 2000000);
      });

      it('[LOG3] Emits a burn event', async function () {
        const { logs } = await this.token.burn(amount, { from });
        const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000';
        assert.equal(logs.length, 2);
        assert.equal(logs[0].event, 'Burn');
        assert.equal(logs[0].args.burner, owner);
        assert.equal(logs[0].args.value, amount);

        assert.equal(logs[1].event, 'Transfer');
        assert.equal(logs[1].args.from, owner);
        assert.equal(logs[1].args.to, ZERO_ADDRESS);
        assert.equal(logs[1].args.value, amount);
        console.log("\t  [LOG3] Anchored data in BlockChain =>"+"\n"+"\t\t\t\t\t{\n\t\t\t\t\t  {\n\
                                             event = "+logs[0].event+",\n\
                                             burner address = "+logs[0].args.burner+",\n\
                                             amount = "+logs[0].args.value+" Clives\n\t\t\t\t\t  },\n\n\t\t\t\t\t  {\n\
                                             event = "+logs[1].event+",\n\
                                             owner address = "+logs[1].args.from+",\n\
                                             recipient address = "+logs[1].args.to+",\n\
                                             amount = "+logs[1].args.value+" Clives\n\t\t\t\t\t  }\n\t\t\t\t\t}");


      });
    });

    describe('- When the given amount is greater than the balance of the sender:', function () {
      const amount = 3000001;

      it('Clives burn failed', async function () {
        await assertRevert(this.token.burn(amount, { from }));
      });
    });
  });

});
