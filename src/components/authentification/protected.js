import React from 'react';
import { Text, View } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import CalendarView from './../tabViews/calendarView.js';
import FeedView from './../tabViews/feedView.js';
import CreateEventView from './../tabViews/createEventView.js';

class Protected extends React.PureComponent{
  constructor(props){
    super(props);
    this.navHeight = 3; //in em
    this.mainHeight = this.getMainWindowHeight();
    this.state = {
      currentTab: 'Calendar',
      tabs: [
        'Calendar',
        'Feed',
        '+',
        'Search',
        'Profile',
      ],
      navHeight: this.navHeight,
      mainHeight: this.mainHeight,
    };
  }

  getMainWindowHeight = () => {
    let windowHeight = window.innerHeight;
    let mainHeight = windowHeight - 16*this.navHeight;
    return(mainHeight);
  }
  changeTab = (tab) =>{
    this.setState({currentTab: tab})
  }

  render(){
    let mainView = null;
    switch (this.state.currentTab) {
      case 'Calendar':
        mainView = <CalendarView userId={this.props.userId} host={this.props.host}/>;
        break;
      case 'Feed':
        mainView = <FeedView userId={this.props.userId} host={this.props.host}/>;
        break;
      case '+':
        mainView = <CreateEventView userId={this.props.userId} host={this.props.host}/>;
        break;
      case 'Search':
        mainView = <Search userId={this.props.userId} host={this.props.host}/>;
        break
      case 'Profile':
        mainView = <Profile setLoginStateFalse={this.props.setLoginStateFalse} userId={this.props.userId} host={this.props.host}/>;
        break;
      default:
        break;
      };

    const styleMain = {
      height: this.state.mainHeight+"px",
      overflowX: 'hidden',
      overflowY: 'scroll',
    };

    return(
      <div>
        <main style={styleMain}>
          {mainView}
        </main>
        <TabNavigation
          changeTab={this.changeTab}
          tabs={this.state.tabs}
          navHeight={this.state.navHeight+"em"}
        />
      </div>

    );
  }
}

class TabNavigation extends React.PureComponent{
  constructor(props){
    super(props);
  }

  handleClick = (e) =>{
    this.props.changeTab(e.target.id);
  }

  render(){
    const styleNav = {
      position: "fixed",
      bottom: "0px",
      width: "100vw",
      height: this.props.navHeight,
      display: "flex",
      flexWrap: "wrap",
      flexDirection: "row",
      justifyContent: "center",
      alignContent: "center"
    };
    return(
      <nav style={styleNav}>
        {this.props.tabs.map(tab =>(
          <div
            onClick={this.handleClick}
            id={tab}
            style={{width: "20vw"}}
          >
            {tab}
          </div>
          )
        )
        }
        </nav>
    );
  }
}

class Profile extends React.Component{
  render() {
    const styleMain = {
      height: '100vh',
      width: '100vw',
    };
    return (
      <main style={styleMain} className={'formContainer'}>
        <div className={"formBox"}>
          <form onSubmit={this.props.setLoginStateFalse}>
            <div className="form-group">
                <input type="submit" className="btn btn-primary" value="Log out"/>
            </div>
          </form>
        </div>
      </main>
    );
  }

}

function Search() {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Search!</Text>
    </View>
  );
}




export default Protected
