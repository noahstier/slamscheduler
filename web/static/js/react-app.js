import React from 'react';
import {Volunteer} from './volunteer';
import {AddVolunteer} from './add_volunteer';
import {all_schedules} from './scheduling';
import {Schedule} from './schedule';
import {ClassOfferings} from './class_offerings';
import {set_at} from './helpers';
import {days, skills} from './canon';
import {List, Map} from 'immutable';

export var ReactApp = React.createClass({
  getInitialState: function() {
    // if (localStorage.slamSchedulerState) {
    //   return JSON.parse(localStorage.slamSchedulerState);
    // }
    // else {
      var blankDay = Map(skills.zip(
        List(Array(skills.size).fill(false))
      ));
      return {
        volunteers: List(),
        classOfferings: Map(days.zip(
          List(Array(days.size).fill(blankDay))
        ))
      }
    // }
  },
  addClicked: function(e) {
    this.saveState({
      volunteers: this.state.volunteers.concat([e])
    });
  },
  volunteerUpdated: function(e) {
    this.saveState({
      volunteers: this.state.volunteers.updateIn(
        [e.volunteer_ind, e.trait, e.trait_ind],
        val => !val
      )
    });
  },
  offeringsUpdated: function(day, skill) {
    this.saveState({
      classOfferings: this.state.classOfferings.updateIn(
        [day, skill],
        offered => !offered
      )
    });
  },
  saveState: function(state) {
    this.setState(state, function() {
      localStorage.slamSchedulerState = JSON.stringify(this.state);
    });
  },
  render: function() {
    var schedules = all_schedules(
      this.state.volunteers,
      this.state.classOfferings
    )
    return (
      <div className="app-container">
        <div className="schedules-container">
          {
            schedules.map((s, i) =>
              <Schedule schedule={s} ind={i} key={Math.random()} />
            )
          }
        </div>
        <div className="volunteers-container">
          {
            this.state.volunteers
              .map((v, i) => 
                <Volunteer 
                  info={v}
                  callback={this.volunteerUpdated} 
                  key={i} 
                  ind={i}
                />
              )
          }
           <AddVolunteer addClicked={this.addClicked}/>
        </div>
        <ClassOfferings offerings={this.state.classOfferings}
           handleClick={this.offeringsUpdated} />
      </div>
    );
  }
});
