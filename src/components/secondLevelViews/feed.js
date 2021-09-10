import React from 'react';
import {Header} from './../elements/headers.js'
import EventPreview from './../elements/eventPreview.js';

export default class Feed extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      events: []
    };
  }

  componentDidMount(){
    console.log('mounted');
    this.fetchEvents();
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

    fetch(this.props.host+"/rest/events/show-all.php", requestOptions)
    .then(result => result.json())
    .then(fetched =>{ this.setState({events: fetched}) })
    .then(console.log(this.state.event))
    .catch(error => console.log('error', error));
  }





  render(){
    let events = this.state.events.map(event => (
      <EventPreview id={event.event_id} event={event} navigation={this.props.navigation}/>
    ));
    return (
      <div className={'view'}>
        <Header title={'Feed'}/>
        {events}
      </div>
    );
  }
}
