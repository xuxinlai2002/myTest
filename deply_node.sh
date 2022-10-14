
cd $HOME/myTest
chmod +x v0.2.2/linux/uptickd
chmod +x v0.2.3/linux/uptickd
cp v0.2.2/linux/uptickd  $GOPATH/bin
cp cosmovisor $GOPATH/bin

#
cd $HOME
rm -rf $HOME/.uptickd
uptickd init test --chain-id=uptick_7000-1

#
curl -o ~/.uptickd/config/config.toml https://raw.githubusercontent.com/UptickNetwork/uptick-testnet/main/uptick_7000-1/config.toml
curl -o ~/.uptickd/config/genesis.json https://raw.githubusercontent.com/UptickNetwork/uptick-testnet/main/uptick_7000-1/genesis.json

#
mkdir -p $HOME/.uptickd/cosmovisor/genesis/bin
mkdir -p $HOME/.uptickd/cosmovisor/upgrades/v0.2.3/bin
cp $HOME/myTest/v0.2.2/linux/uptickd $HOME/.uptickd/cosmovisor/genesis/bin
cp $HOME/myTest/v0.2.3/linux/uptickd $HOME/.uptickd/cosmovisor/upgrades/v0.2.3/bin


export DAEMON_NAME=uptickd
export DAEMON_HOME=$HOME/.uptickd 
export DAEMON_RESTART_AFTER_UPGRADE=true

nohup cosmovisor run start --home $HOME/.uptickd  > $HOME/node.log 2>&1 & 