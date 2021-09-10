import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import LoginForm from './../forms/loginform.js'
import RegisterForm from './../forms/registerform.js'



const AuthStack = createStackNavigator();

class Authentification extends React.PureComponent{
  constructor(props){
    super(props);
  }
  render(){
    return(
        <NavigationContainer independent={true}>
          <AuthStack.Navigator screenOptions={{headerShown: false}}>
            <AuthStack.Screen name="LogIn">
              {props => <LogIn {...props} host={this.props.host} changeUserId={this.props.changeUserId} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </AuthStack.Screen>
            <AuthStack.Screen name="Register">
              {props => <Register {...props} host={this.props.host} changeUserId={this.props.changeUserId} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </AuthStack.Screen>
          </AuthStack.Navigator>
        </NavigationContainer>
    );
  }
}



class LogIn extends React.Component {
  render() {
    const styleMain = {
      height: '100vh',
      width: '100vw',
    };

    return (
      <main style={styleMain} className={'formContainer'}>
        <div className={"formBox"}>
          <h2>Sign in</h2>
          <LoginForm host={this.props.host}  changeUserId={this.props.changeUserId} setLoginStateTrue={this.props.setLoginStateTrue}/>
          <p>
            Don't have an account? <a onClick={() => this.props.navigation.navigate('Register')}>Sign up!</a>
          </p>
        </div>
      </main>
    );
  }
}

class Register extends React.Component {
  render() {
    const styleMain = {
      height: '100vh',
      width: '100vw',
    };

    return (
      <main style={styleMain} className={'formContainer'}>
        <div className={"formBox"}>
          <h2>Register</h2>
          <RegisterForm host={this.props.host} changeUserId={this.props.changeUserId} setLoginStateTrue={this.props.setLoginStateTrue}/>
          <p>
            Already have an account? <a onClick={() => this.props.navigation.navigate('LogIn')}>Log in!</a>
          </p>
        </div>
      </main>
    );
  }
}


export default Authentification
