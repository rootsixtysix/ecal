import React from 'react';
import {Header} from './../elements/headers.js'
import EventPreview from './../elements/eventPreview.js';
import CreateEventForm from './../forms/createEventForm.js'

export default class Calendar extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      event: {},
      events: []
      //event: this.props.event,
    };
  }

  componentDidMount(){
    console.log('mounted');
    this.fetchEvent(1);
    this.fetchEvents();
  }

  fetchEvent = (id) => {
    let headers = new Headers();
    headers.append("Content-Type", "application/json");

    let data = {
      "id": id,
    };

    let requestOptions = {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(data),
      redirect: 'follow'
    };

    console.log(this.props.host);

    fetch(this.props.host+"/rest/events/show.php", requestOptions)
    .then(result => result.json())
    .then(fetched =>{ this.setState({event: fetched}) })
    .then(console.log(this.state.event))
    .catch(error => console.log('error', error));
  }

  fetchEvents = () => {
    let headers = new Headers();
    headers.append("Content-Type", "application/json");

    let data = {
      "userId": this.props.userId,
    };

    let requestOptions = {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(data),
      redirect: 'follow'
    };

    console.log(this.props.host);

    let dummy = [{"title": "bla", "id": 4}]

    fetch(this.props.host+"/rest/events/showBookmarked.php", requestOptions)
    .then(result => result.json())
    .then(fetched =>{ this.setState({events: fetched}) })
    .then(console.log(this.state.event))
    .catch(error => console.log('error', error));
  }





  render(){
    let events = this.state.events.map(event => (
      <EventPreview id={event.event_id} event={event} navigation={this.props.navigation}/>
    ));
    const msg = this.state.events.length<1? "no bookmarkes events yet" : '';
    return (
      <div className={'view'}>
        <Header title={'Calendar'}/>
        {events}
        {msg}
      </div>
    );
  }
}
