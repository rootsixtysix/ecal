import React from 'react';
//import ReactDOM from 'react-dom';

import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';

export default class CreateEventForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {
    };
  }

  updateState = (e) => {
    let name = e.target.name;
    let value = e.target.value;
    this.setState({[name]: value});
  }

  handleStartChange = (e) => {
    let start = e.target.value;
    if (this.isDateTimeFormat(start)){
      this.setState({start_msg: ''});
    }else{
      this.setState({start_msg: 'input must be yyyy-mm-dd hh:mm:ss'});
    }
    this.updateState(e);
  }

  isDateTimeFormat = (string) => {
    let validPattern = /\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}/;
    if (validPattern.test(string)){
      return true;
    }else{
      return false;
    }
  }

  handleSubmit = (e) =>{
    e.preventDefault();

    if( this.state.title!='' &&  this.state.location!='' && this.isDateTimeFormat(this.state.start)){
      let data = {
        userId: this.props.userId,
        privacy: 'public',
        title: this.state.title,
        location: this.state.location,
        start: this.state.start,
        description: this.state.description,
      };
      let headers = new Headers();
      headers.append("Content-Type", "application/json");

      let requestOptions = {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(data),
        redirect: 'follow'
      };
      console.log(this.props.host);

      fetch(this.props.host+"/rest/events/create.php", requestOptions)
      .then(response => response.json())
      .then(result => {
        if (result.wasSuccesful===true){
          this.setState({form_msg: 'Created Event!'});
          this.props.setLoginStateTrue();
        }else{
          this.setState({form_msg: 'Error while creating!'});
        }
      })
      .catch(error => console.log('error', error));
    }else{
      this.setState({form_msg: 'Fill out all forms correctly!'});
    }
  }



  render() {

    return (
      <form id='registerForm' onSubmit={this.handleSubmit} style={{maxWidth: "20em"}}>
        <div className="form-group">
          <label>Title</label>
          <input type="text" name="title" className="form-control" onChange={this.updateState}/>
          <div className="help-block">{this.state.title_msg}</div>
        </div>
        <div className="form-group">
          <label>Location</label>
          <input type="text" name="location" className="form-control" onChange={this.updateState}/>
          <div className="help-block">{this.state.location_msg}</div>
        </div>
        <div className="form-group">
          <label>Date & Time</label>
          <input type="text" name="start" className="form-control" onChange={this.handleStartChange}/>
          <div className="help-block">{this.state.start_msg}</div>
        </div>
        <div className="form-group">
          <label>Description</label>
          <textarea type="text" name="description" rows="10" className="form-control" onChange={this.updateState}>
          </textarea>
          <div className="help-block">{this.state.description_msg}</div>
        </div>
        <div className="form-group">
            <input type="submit" className="btn btn-primary" value="Create"/>
            <div className="help-block">{this.state.form_msg}</div>
        </div>
      </form>
    );
  }
}
