import { 
    web3Loaded,
    web3AccountLoaded,
    tokenLoaded,
    exchangeLoaded
} from "./actions"

import Web3 from 'web3'

import Token from '../abis/Token.json'
import Exchange from '../abis/Exchange.json'

export const loadWeb3 = (dispatch) => {
    const web3 = new Web3(Web3.givenProvider || "http://localhost:7545")
    dispatch(web3Loaded(web3))
    return web3
}

export const loadAccount = async (web3, dispatch) => {
    try{
        const accounts = await web3.eth.getAccounts()
        console.log(accounts)
        const account = accounts[2]
        dispatch(web3AccountLoaded(account))
        return account
    }catch(e){
        window.alert('account error')
        console.log(e)
        return null
    }
   
}

export const loadToken = async (web3, networkId, dispatch) => {
    try{
        const token = web3.eth.Contract(Token.abi, Token.networks[networkId].address)
        dispatch(tokenLoaded(token))
        return token
    }catch(e){
        window.alert('Contract not deployed to the current network. Please select another network with Metamask.')
        return null
    }
}

export const loadExchange = async (web3, networkId, dispatch) => {
    try{
        const exchange = web3.eth.Contract(Exchange.abi, Exchange.networks[networkId].address)
        dispatch(exchangeLoaded(exchange))
        return exchange
    }catch(e){
        window.alert('Exchange not deployed to the current network. Please select another network with Metamask.')
        return null
    }
}

