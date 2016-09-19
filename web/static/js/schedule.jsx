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
    var skills_to_show = skills
      .map(skill =>
        this.props.classes.get(skill) ? 
          {name: skill, instructors: this.props.classes.get(skill)} : false
      )
      .filter(_ => _)

    return (
      <div className="schedule-day">
        <h2 className="day-header">{this.props.name}</h2>
          {
            skills_to_show.map(({name, instructors}) =>
              <Class key={name} skill={name} instructors={instructors} />
            )
          }
      </div>
    );
  }
});

export var Schedule = React.createClass({
  render: function() {
    return (
      <div>
        <h1>{this.props.ind}</h1>
        <div className="schedule">
          {
            days.map(day =>
              <Day key={day} name={day} classes={this.props.schedule.get(day)} />
            )
          }
        </div>
      </div>
    );
  }
});

