import React from 'react';
import {days, skills} from './canon';
import {CustomCheckbox} from './custom_checkbox';

var Class = React.createClass({
  handleClick: function() {
    this.props.handleClick(this.props.skill);
  },
  render: function() {
    return (
      <div className="schedule-class">
        <CustomCheckbox text={this.props.skill} checked={this.props.checked} 
          handleClick={this.handleClick} />
      </div>
    );
  }
});

var Day = React.createClass({
  handleClick: function(skill) {
    this.props.handleClick(this.props.name, skill);
  },
  render: function() {
    return (
      <div className="schedule-day">
        <h2 className="day-header">{this.props.name}</h2>
          {
            skills.map(skill =>
              <Class key={skill} skill={skill} checked={this.props.classes[skill]} 
                handleClick={this.handleClick} />
            )
          }
      </div>
    );
  }
});

export var ClassOfferings = React.createClass({
  getInitialState: function() {
    return this.props.initialData;
  },
  handleClick: function(day, skill) {
    // var newState = {};
    // newState[day] = this.state[day];
    // newState[day][skill] = !newState[day][skill];
    // this.setState(newState);
    // this.props.handleClick(newState);
    this.props.handleClick(day, skill)
  },
  render: function() {
    return (
      <div className="classes-container">
        {
          days.map(day =>
            <Day name={day} key={day} classes={this.state[day]} 
              handleClick={this.handleClick} />
          )
        }
      </div>
    );
  }
})
