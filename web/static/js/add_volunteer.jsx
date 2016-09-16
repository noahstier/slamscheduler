import React from 'react';
import {CustomCheckbox} from './custom_checkbox';
import {days, skills} from './canon';
import {zip} from './helpers';

export var AddVolunteer = React.createClass({
  getInitialState: function() {
    return {
      name: "",
      availability: [false, false, false, false, false],
      skills: [false, false, false, false, false, false]
    }
  },
  checkboxClicked: function(e) {
    var new_trait = this.state[e.trait];
    new_trait[e.ind] = !new_trait[e.ind];
    // computed keys would be nice here
    var newState = {};
    newState[e.trait] = new_trait;
    this.setState(newState);
  },
  nameChanged: function(e) {
    this.setState({
      name: e.target.value
    });
  },
  addClicked: function() {
    this.props.addClicked(this.state)
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
              zip(days, this.state.availability).map((day, i) => 
                <li key={i}>
                  <CustomCheckbox handleClick={this.checkboxClicked}
                    checked={day[1]} trait="availability" ind={i} 
                    text={day[0]} />
                </li>
              )
            }
          </ul>
          <ul className="skills">
            {
              zip(skills, this.state.skills).map((skill, i) =>
                <li key={i}>
                  <CustomCheckbox handleClick={this.checkboxClicked}
                    checked={skill[1]} trait="skills" ind={i}
                    text={skill[0]} />
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
