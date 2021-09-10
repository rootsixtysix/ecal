import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import Feed from './../secondLevelViews/feed.js';
import Event from './../secondLevelViews/event.js';


const FeedStack = createStackNavigator();

export default class FeedView extends React.PureComponent{
  constructor(props){
    super(props);
  }
  render(){
    return(
        <NavigationContainer independent={true}>
          <FeedStack.Navigator screenOptions={{headerShown: false}}>
            <FeedStack.Screen name="Feed">
              {props => <Feed {...props} userId={this.props.userId} host={this.props.host} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </FeedStack.Screen>
            <FeedStack.Screen name="Event">
              {props => <Event {...props} userId={this.props.userId} host={this.props.host} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </FeedStack.Screen>
          </FeedStack.Navigator>
        </NavigationContainer>
    );
  }
}
