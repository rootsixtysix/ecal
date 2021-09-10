import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import Calendar from './../secondLevelViews/calendar.js';
import Event from './../secondLevelViews/event.js';


const CalStack = createStackNavigator();

class CalendarView extends React.PureComponent{
  constructor(props){
    super(props);
  }
  render(){
    return(
        <NavigationContainer independent={true}>
          <CalStack.Navigator screenOptions={{headerShown: false}}>
            <CalStack.Screen name="Calendar">
              {props => <Calendar {...props} userId={this.props.userId} host={this.props.host} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </CalStack.Screen>
            <CalStack.Screen name="Event">
              {props => <Event {...props} userId={this.props.userId} host={this.props.host} setLoginStateTrue={this.props.setLoginStateTrue}/> }
            </CalStack.Screen>
          </CalStack.Navigator>
        </NavigationContainer>
    );
  }
}
export default CalendarView
