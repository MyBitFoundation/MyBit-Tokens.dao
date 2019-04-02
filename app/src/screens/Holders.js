import React from 'react'
import styled from 'styled-components'
import { Table, TableHeader, TableRow } from '@aragon/ui'
import HolderRow from '../components/HolderRow'
import SideBar from '../components/SideBar'

class Holders extends React.Component {
  static defaultProps = {
    holders: [],
  }
  render() {
    const {
      holders,
      maxAccountTokens,
      claimAmount,
      onLockTokens,
      onUnlockTokens,
      onBurnTokens,
      tokenAddress,
      tokenDecimalsBase,
      ethDecimalsBase,
      tokenName,
      tokenSupply,
      tokenSymbol,
      erc20Symbol,
      tokenTransfersEnabled,
      userAccount,
    } = this.props
    
    return (
      <TwoPanels>
        <Main>
          <Table
            header={
              <TableRow>
                <TableHeader title='Holder' />
                <TableHeader title='Contributed'  align="right"/>
                <TableHeader title="Balance" align="right" />
                <TableHeader title="" />
              </TableRow>
            }
          >
            {holders.map(({ address, balance, contribution, claimed }) => (
              <HolderRow
                key={address}
                address={address}
                balance={balance}
                contribution={contribution}
                claimed={claimed}
                claimAmount={claimAmount}
                isCurrentUser={userAccount && userAccount === address}
                maxAccountTokens={claimed ? maxAccountTokens.add(claimAmount) : maxAccountTokens}
                erc20Symbol={erc20Symbol}
                tokenDecimalsBase={tokenDecimalsBase}
                ethDecimalsBase={ethDecimalsBase}
                onLockTokens={onLockTokens}
                onUnlockTokens={onUnlockTokens}
                onBurnTokens={onBurnTokens}
              />
            ))}
          </Table>
        </Main>
        <SideBar
          holders={holders}
          tokenAddress={tokenAddress}
          tokenDecimalsBase={tokenDecimalsBase}
          tokenName={tokenName}
          tokenSupply={tokenSupply}
          tokenSymbol={tokenSymbol}
          tokenTransfersEnabled={tokenTransfersEnabled}
        />
      </TwoPanels>
    )
  }
}

const Main = styled.div`
  width: 100%;
`
const TwoPanels = styled.div`
  display: flex;
  width: 100%;
  min-width: 800px;
`

export default Holders
