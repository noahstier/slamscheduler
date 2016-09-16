import React from 'react';
import {Volunteer} from './volunteer';
import {AddVolunteer} from './add_volunteer';
import {all_schedules} from './scheduling';
import {Schedule} from './schedule';
import {ClassOfferings} from './class_offerings';
import {set_at} from './helpers';
import {days, skills} from './canon';

export var ReactApp = React.createClass({
  getInitialState: function() {
    if (localStorage.slamSchedulerState) {
      return JSON.parse(localStorage.slamSchedulerState);
    }
    else {
      var classOfferings = {};
      days.forEach(function(day) {
        classOfferings[day] = {};
        skills.forEach(function(skill) {
          classOfferings[day][skill] = false;
        });
      });
      return {
        volunteers: [],
        n_volunteers: 0,
        classOfferings: classOfferings
      }
    }
  },
  addClicked: function(e) {
    this.saveState({
      volunteers: this.state.volunteers.concat([e]),
      n_volunteers: this.state.n_volunteers + 1
    });
  },
  volunteerUpdated: function(v, ind) {
    this.saveState({
      volunteers: set_at(this.state.volunteers, ind, v)
    });
  },
  offeringsUpdated: function(day, skill) {
    var newState = this.state.classOfferings;
    newState[day][skill] = !newState[day][skill];
    this.saveState({
      classOfferings: newState
    });
    this.save
  },
  saveState: function(state) {
    this.setState(state, function() {
      localStorage.slamSchedulerState = JSON.stringify(this.state);
    });
  },
  render: function() {
    var schedules = all_schedules(this.state.volunteers, this.state.classOfferings);
    return (
      <div className="app-container">
        <div className="schedules-container">
          {
            schedules.map((s, i) =>
              <Schedule initialData={s} ind={i} key={Math.random()} />
            )
          }
        </div>
        <div className="volunteers-container">
          {
            this.state.volunteers
              .slice(0, this.state.n_volunteers)
              .map((v, i) => 
                  <Volunteer initialData={v} callback={this.volunteerUpdated} 
                    key={i} ind={i} />
              )
          }
           <AddVolunteer addClicked={this.addClicked}/>
        </div>
        <ClassOfferings initialData={this.state.classOfferings}
           handleClick={this.offeringsUpdated} />
      </div>
    );
  }
});
