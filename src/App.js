/*import packages*/
import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
/*import components*/
import Protected from './components/authentification/protected.js';
import Authentification from './components/authentification/authentification.js';
import './css/font_and_color.css';
import './css/form.css';
import './css/button.css';


const AppStack = createStackNavigator();

class App extends React.Component{
  constructor(props){
    super(props);
    this.state = {
      userId: '0',
      logedIn: false,
      //host: 'http://localhost/ecal',
      host: 'http://0x000.space/ecal'
    };
  }


  setLoginStateTrue = ()=>{
    this.setState({logedIn: true});
  }

  setLoginStateFalse = ()=>{
    this.setState({logedIn: false});
  }

  changeUserId = (id) => {
    this.setState({userId: id});
  }

render(){
  let navigation = null;
  this.state.logedIn ? (
    navigation = <AppStack.Screen name="Authetificated">
                    {props => <Protected {...props} host={this.state.host} userId={this.state.userId} setLoginStateFalse={this.setLoginStateFalse}/> }

                  </AppStack.Screen>
  ):(
    navigation = <AppStack.Screen name="Welcome">
                    {props => <Authentification {...props} host={this.state.host} changeUserId={this.changeUserId} setLoginStateTrue={this.setLoginStateTrue}/> }
                  </AppStack.Screen>
  )
  return(
      <NavigationContainer>
        <AppStack.Navigator screenOptions={{headerShown: false}}>
          {navigation}
        </AppStack.Navigator>
      </NavigationContainer>
  );
}

}

export default App;
