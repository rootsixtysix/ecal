import React from 'react';

const styleHeader = {
  position: 'sticky',
  top: '0em,',
  display: 'flex',
  justifyContent: 'center',
  alignContent: 'center',
};
const styleButton = {
  position: 'fixed',
  top: '0em,',
  left: '0em',
};

class HeaderWBackButton extends React.PureComponent{
  constructor(props){
    super(props);
  }

  render(){
    return(
      <header style={styleHeader}>
        <button onClick={() => this.props.navigation.goBack()} style={styleButton}>🠔</button>
        <h1>{this.props.title}</h1>
      </header>
    );
  }
}

class Header extends React.PureComponent{
  constructor(props){
    super(props);
  }

  render(){
    return(
      <header style={styleHeader}>
        <h1>{this.props.title}</h1>
      </header>
    );
  }
}

export {
  Header,
  HeaderWBackButton
}
