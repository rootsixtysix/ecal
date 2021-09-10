import React from 'react';

class LoginForm extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      username: '',
      password: ''
    };
  }

  updateState = (e) => {
    let name = e.target.name;
    let value = e.target.value;
    this.setState({[name]: value});
  }

  handleNameChange = (e) => {
    this.updateState(e);
  }

  handlePasswordChange = (e) => {
    this.updateState(e);
  }

  isMail = (string) => {
    let validMailPattern = /\S+@\S+\.\w{2}/;
    if (validMailPattern.test(string)){
      return true;
    }else{
      return false;
    }
  }

  handleSubmit = (e) => {
    e.preventDefault();

    if ( this.state.username==='' && this.state.password==='' ) {
      this.setState({form_msg: 'Enter username/mail and password!'})
    }
    else{
      let data = {};
      if (this.isMail(this.state.username)){
        data = {
          "mail": this.state.username,
          "username": '',
          "password": this.state.password,
        };
      }else{
        data = {
          "username": this.state.username,
          "mail": '',
          "password": this.state.password,
        };
      }
      let headers = new Headers();
      headers.append("Content-Type", "application/json");

      let requestOptions = {
        method: 'POST',
        headers: headers,
        body: JSON.stringify(data),
        redirect: 'follow'
      };
      console.log(this.props.host);

      fetch(this.props.host+"/rest/register/login.php", requestOptions)
      .then(response => response.json())
      .then(result => {
        if (result.id!=='0'){
          this.setState({form_msg: 'Succes!'});
          this.props.setLoginStateTrue();
          this.props.changeUserId(result.id);
        }else{
          this.setState({form_msg: 'Password and username/mail don\'t match!'});
        }
      })
      .catch(error => console.log('error', error));
    }


  }


  render() {
    return (
      <form id='registerForm' onSubmit={this.handleSubmit} style={{maxWidth: "20em"}}>
        <div className="form-group">
          <label>Username Or Mail</label>
          <input type="text" name="username" className="form-control" onChange={this.handleNameChange}/>
          <div className="help-block">{this.state.username_msg}</div>
        </div>
        <div className="form-group">
          <label>Password</label>
          <input type="password" name="password" className="form-control" onChange={this.handlePasswordChange}/>
          <div className="help-block">{this.state.password_msg}</div>
        </div>
        <div className="form-group">
            <input type="submit" className="btn btn-primary" value="Log In"/>
            <div className="help-block">{this.state.form_msg}</div>
        </div>
      </form>
    );
  }
}

export default LoginForm
