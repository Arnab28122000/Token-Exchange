const Token = artifacts.require('./Token')

require('chai').use(require('chai-as-promised')).should()

contract('Token', (accounts) => {
    const name = 'Arnab'
    const symbol = 'AB'
    const decimals = '18'
    const totalSupply = '1000000000000000000000000'

    let token

    beforeEach(async () => {
        token = await Token.new()
    })

    describe('deployment', () => {
        it('tracks the name', async () => {
            //Fetch token from blockchain
            
            const result = await token.name()
            //Read token name here...
            result.should.equal(name)
            //The token name is 'My name'
        })

        it('tracks the symbol', async () => {
            const result = await token.symbol()
            result.should.equal(symbol)
        })

        it('tracks the decimals', async () => {
            const result = await token.decimals()
            result.toString().should.equal(decimals)
        })

        it('tracks the total supply', async () => {
            const result = await token.totalSupply()
            result.toString().should.equal(totalSupply)
        })
    })
})