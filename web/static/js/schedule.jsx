import React from 'react';
import {days, skills} from './canon';
import CustomCheckbox from './custom_checkbox';

// <li key={instructor} className="class-instructor">{instructor}</li>

var Class = React.createClass({
  render: function() {
  var a = 3;
    return (
      <div className="schedule-class">
        <h2 className="class-header">{this.props.skill}</h2>
        <ul>
          {
            this.props.instructors.map(instructor =>
              <li key={instructor}>{instructor}</li>
            )
          }
        </ul>
      </div>
    );
  }
});

var Day = React.createClass({
  render: function() {
    var skills_to_show = skills.reduce((acc, skill) =>
      this.props.classes[skill] ? 
        [...acc, {name: skill, instructors: this.props.classes[skill]}] : acc
    , [])
    return (
      <div className="schedule-day">
        <h2 className="day-header">{this.props.name}</h2>
          {
            skills_to_show.map(skill =>
              <Class key={skill.name} skill={skill.name} 
                instructors={skill.instructors} />
            )
          }
      </div>
    );
  }
});

export var Schedule = React.createClass({
  getInitialState: function() {
    return {days: this.props.initialData};
  },
  render: function() {
    return (
      <div>
        <h1>{this.props.ind}</h1>
        <div className="schedule">
          {
            days.map(day =>
              <Day key={day} name={day} classes={this.state.days[day]} />
            )
          }

        </div>
      </div>
    );
  }
});

