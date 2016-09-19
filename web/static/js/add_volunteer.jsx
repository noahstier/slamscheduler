import React from 'react';
import {CustomCheckbox} from './custom_checkbox';
import {days, skills} from './canon';
import {List, Map} from 'immutable';

export var AddVolunteer = React.createClass({
  getInitialState: function() {
    return {
      name: "",
      availability: List([false, false, false, false, false]),
      skills: List([false, false, false, false, false, false])
    }
  },
  checkboxClicked: function(e) {
    this.setState({
      [e.trait]: this.state[e.trait].update(
        e.ind,
        (_ => !_)
      )
    });
  },
  nameChanged: function(e) {
    this.setState({
      name: e.target.value
    });
  },
  addClicked: function() {
    this.props.addClicked(Map(this.state))
    this.setState(this.getInitialState());
  },
  render: function() {
    return (
      <div className="volunteer">
        <input placeholder="Name" onChange={this.nameChanged} 
          value={this.state.name} />
        <div className="volunteer-options">
          <ul className="availability">
            {
              days.zip(this.state.availability).map(([day, checked], i) => 
                <li key={i}>
                  <CustomCheckbox handleClick={this.checkboxClicked}
                    checked={checked} trait="availability" ind={i} 
                    text={day} />
                </li>
              )
            }
          </ul>
          <ul className="skills">
            {
              skills.zip(this.state.skills).map(([skill, checked], i) =>
                <li key={i}>
                  <CustomCheckbox handleClick={this.checkboxClicked}
                    checked={checked} trait="skills" ind={i}
                    text={skill} />
                </li>
              )
            }
          </ul>
        </div>
        <button onClick={this.addClicked} >+</button>
      </div>
    );
  }
});
