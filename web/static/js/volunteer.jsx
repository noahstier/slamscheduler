import React from 'react';
import {CustomCheckbox} from './custom_checkbox';
import {days, skills} from './canon';
import {Map} from 'immutable';

const traits = {
  days: days,
  skills: skills
}

export var Volunteer = React.createClass({
  checkboxClicked: function(e) {
    this.props.callback({
      trait: e.trait,
      trait_ind: e.ind,
      volunteer_ind: this.props.ind
    });
  },
  render: function() {
    return (
      <div className="volunteer">
        <p>{this.props.info.get('name')}</p>
        <div className="volunteer-options">
          <ul className="availability">
            {
              days.zip(this.props.info.get('availability')).map(([day, checked], i) => 
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
              skills.zip(this.props.info.get('skills')).map(([skill, checked], i) =>
                <li key={i}>
                  <CustomCheckbox handleClick={this.checkboxClicked}
                    checked={checked} trait="skills" ind={i}
                    text={skill} />
                </li>
              )
            }
          </ul>
        </div>
      </div>
    );
  }
});
