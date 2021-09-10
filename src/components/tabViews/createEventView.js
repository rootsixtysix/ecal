import React from 'react';

import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';

import CreateEventForm from './../forms/createEventForm.js'
import LoginForm from './../forms/loginform.js'

export default class CreateEventView extends React.PureComponent {
  render() {
    const styleMain = {
      height: '100vh',
      width: '100vw',
    };

    return (
      <main style={styleMain} className={'formContainer'}>
        <div className={"formBox"}>
            <CreateEventForm userId={this.props.userId} host={this.props.host}/>
        </div>
      </main>
    );
  }
}


//createEventForm

const useStyles = makeStyles((theme) => ({
  container: {
    display: 'flex',
    flexWrap: 'wrap',
    color: 'white',
  },
  textField: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
    backgroundColor: "hsla(168, 100%, 42%, 0.85)",
    width: 200,
  },
}));

function DatePickers() {
  const classes = useStyles();

  return (
    <form className={classes.container} noValidate>
      <TextField
        id="date"
        label="Birthday"
        type="date"
        defaultValue="2017-05-24"
        className={classes.textField}
        InputLabelProps={{
          shrink: true,
        }}
      />
    </form>
  );
}
