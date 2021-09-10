import React from 'react';

class EventPreview extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      event: this.props.event,
    };
  }

  render() {
    const showEvent = () =>{
      this.props.navigation.navigate('Event', {event: this.props.event, id: this.props.id})
    };

    const style = {
        display: 'block',
        textAlign: 'left',
        margin: '0.5em',
        padding: '0 0.2em',
    };
    return (
      <span onClick={showEvent} className={'eventPreview'} style={style}>
        <p><b>{this.props.event.title}</b></p>
        <p> {this.props.event.id}</p>
        <p> {this.props.event.start} | </p>
        <p>{this.props.event.category} </p>
        <p>more...</p>
      </span>
    );
  }
}

export default EventPreview
