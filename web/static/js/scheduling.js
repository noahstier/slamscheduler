import {days, skills} from './canon';
import {List, Map, fromJS} from 'immutable';

function possible_slots(volunteer) {
  var leskills = skills
    .map((skill, i) =>
      volunteer.get('skills').get(i) ? skill : false
    )
    .filter(_ => _)

  var ledays = days
    .map((day, i) =>
      volunteer.get('availability').get(i) ? day : false
    )
    .filter(_ => _)

  return ledays.flatMap(day =>
    leskills.map(skill =>
      Map({day: day, skill: skill})
    )
  )
}

function available(schedule, slot) {
  var leclass = schedule
    .get(slot.get('day'))
    .get(slot.get('skill'));

  if (leclass)
    return leclass.size < 2;
  else
    return false
}

function schedules(volunteers, current_schedule) {
  if (volunteers.size == 0) {
    return List([current_schedule]);
  }

  var first_volunteer = volunteers.first();
  var other_volunteers = volunteers.shift();

  var slots = possible_slots(first_volunteer)
    .filter(slot => available(current_schedule, slot));

  if (slots.size == 0) {
    return schedules(
      other_volunteers,
      current_schedule
    );
  }

  //var mapFunc = other_volunteers.size <= 1 ? 'map' : 'flatMap'
  //return slots[mapFunc](slot =>
  return slots.flatMap(slot =>
    schedules(
      other_volunteers,
      current_schedule.updateIn(
        [slot.get('day'), slot.get('skill')],
        (leclass) => leclass.push(first_volunteer.get('name'))
      )
    )
  );
}

export function all_schedules(volunteers, classes_offered) {
  volunteers = fromJS(volunteers);
  var initial_schedule = fromJS(classes_offered).map((classes, day) =>
    classes
      .map((offered, skill) => offered ? List() : false)
      .filter(_ => _)
  );
  var scheds = schedules(volunteers, initial_schedule);
  return scheds;
}

// var class_offerings = {"Mo":{"Guitar":true,"Piano":false,"Voice":false,"Percussion":false,"Rockband":false,"Songwriting":false},"Tu":{"Guitar":false,"Piano":false,"Voice":false,"Percussion":false,"Rockband":false,"Songwriting":false},"We":{"Guitar":true,"Piano":false,"Voice":true,"Percussion":false,"Rockband":false,"Songwriting":false},"Th":{"Guitar":false,"Piano":false,"Voice":false,"Percussion":false,"Rockband":false,"Songwriting":false},"Fr":{"Guitar":false,"Piano":false,"Voice":false,"Percussion":false,"Rockband":false,"Songwriting":false}};

// var volunteers = [{"name":"noah","availability":[false,false,false,false,false],"skills":[false,false,false,false,false,false]},{"name":"roi","availability":[true,false,true,false,false],"skills":[true,false,true,false,false,false]}];
