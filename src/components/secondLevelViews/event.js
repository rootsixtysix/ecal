import React from 'react';
import {HeaderWBackButton} from './../elements/headers.js'

class Event extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      event: this.props.route.params.event,
    };
  }

  render() {
    const style = {
        display: 'block',
        textAlign: 'left',
        margin: '0.5em',
        padding: '0 0.2em',
    };

    return (
      <div className={'view'}>
      <HeaderWBackButton title={this.state.event.title} navigation={this.props.navigation}/>

      <span className={'event'} style={style}>
        <p> {this.state.event.start} | </p>
        <p>{this.state.event.category} </p>
        <p>{this.state.event.location} </p>
        <p>{this.state.event.artist} </p>
        <p>{this.state.event.description}</p>
      </span>
      </div>
    );
  }
}



export default Event
