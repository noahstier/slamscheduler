import React from 'react';
import {CustomCheckbox} from './custom_checkbox';
import {days, skills} from './canon';
import {zip} from './helpers';

export var Volunteer = React.createClass({
  getInitialState: function() {
    return this.props.initialData;
  },
  checkboxClicked: function(e) {
    var new_trait = this.props.initialData[e.trait];
    new_trait[e.ind] = !new_trait[e.ind];
    // computed keys would be nice here
    var newState = {};
    newState[e.trait] = new_trait;
    this.setState(newState);
    this.props.callback(this.state, this.props.ind);
  },
  render: function() {
    return (
      <div className="volunteer">
        <p>{this.state.name}</p>
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
      </div>
    );
  }
});
