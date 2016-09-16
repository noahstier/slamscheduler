import {days, skills} from './canon';
import {zip, drop_at, flat_map} from './helpers';

var Immutable = require('immutable');

function format_volunteer(volunteer) {
  return {
    name: volunteer.name,
    skills: zip(volunteer.skills, skills)
      .filter(pair => pair[0])
      .map(pair => pair[1]),
    availability: zip(volunteer.availability, days)
      .filter(pair => pair[0])
      .map(pair => pair[1])
  }
}

function possible_slots(volunteer) {
  return volunteer.skills.reduce((acc, skill) =>
    acc.concat(
      volunteer.availability.map(day =>
        ({skill: skill, day: day})
      )
    )
  , [])
}

function class_offered(slot, slots) {
  return slots
    .filter(s => s.day == slot.day && s.skill == slot.skill) 
    .length > 0
}

function includes(slots, slot) {
  var found = false;
  slots.some(function(s) {
    if (s.day == slot.day && s.skill == slot.skill) {
      found = true;
      return true;
    }
  });
  return found;
}


function drop_one(slots, slot) {
  var ind = -1;
  slots.some(function(s, i) {
    if (s.day == slot.day && s.skill == slot.skill) {
      ind = i;
      return true;
    }
  });
  return drop_at(slots, ind);
}

function format_schedules(schedules) {
  var str = Object.prototype.toString.call(schedules[0]);
  if (str == "[object Undefined]") return [];
  if (str == "[object Object]") {
    // schedules is a list of slots
    return format_schedule(schedules);
  }
  if (str == "[object Array]") {
    // schedules is a list of lists of ... of slots
    var result = flat_map(schedules, format_schedules);
    return result;
    // return flat_map(schedules, format_schedules);
  }
}
  
function format_schedule(schedule) {
  return schedule.reduce(function(acc, slot) {
    var day = acc[slot.day];
    var le_class = (day[slot.skill] || []).concat([slot.name]);
    acc[slot.day][slot.skill] = le_class;
    return acc;
  }, {
    "Mo": {},
    "Tu": {},
    "We": {},
    "Th": {},
    "Fr": {}
  });
}

// function generate_schedules(volunteers, open_slots, current_schedule) {
//   if (open_slots.length == 0 || volunteers.length == 0) {
//     return current_schedule;
//   }
// 
//   var first_volunteer = volunteers[0];
//   var other_volunteers = volunteers.slice(1);
// 
//   var slots = possible_slots(first_volunteer)
//     .filter(slot => includes(open_slots, slot))
// 
//   if (slots.length == 0) {
//     return generate_schedules(
//       other_volunteers,
//       open_slots,
//       current_schedule
//     );
//   }
//   else {
//     return slots.map(slot => 
//       generate_schedules(
//         other_volunteers,
//         drop_one(open_slots, slot),
//         current_schedule
//       )
//     );
//   }
// }

function generate_schedules(volunteers, open_slots, taken_slots=[]) {
  if (open_slots.length == 0 || volunteers.length == 0) return taken_slots;

  var first_volunteer = volunteers[0];
  var other_volunteers = volunteers.slice(1);

  var slots = possible_slots(first_volunteer)
    .filter(slot => includes(open_slots, slot))

  if (slots.length == 0) {
    return generate_schedules(
      other_volunteers,
      open_slots,
      taken_slots
    );
  }
  else {
    return slots.map(slot => generate_schedules(
      other_volunteers,
      drop_one(open_slots, slot),
      [...taken_slots, Object.assign(slot, {name: first_volunteer.name})]
    ));
  }
}

export function all_schedules(volunteers, classes) {
  volunteers = volunteers.map(format_volunteer);
  var taken_slots = [];
  var open_slots = [];
  for (var day in classes) {
    for (var skill in classes[day]) {
      if (classes[day][skill]) {
        open_slots.push({skill: skill, day: day});
      }
    }
  }
  open_slots = open_slots.map(slot =>
    Immutable.Map(slot)
  )
  var schedules = generate_schedules(volunteers, open_slots, taken_slots);
  return format_schedules(schedules);
}
