export function drop_at(objs, ind) {
  return objs.slice(0, ind).concat(objs.slice(ind+1));
}

export function set_at(arr, ind, val) {
  return arr.map((el, i) =>
    i == ind ? val : el
  )
}

export function flat_map(arr, fun) {
  return arr
    .map(fun)
    .reduce((acc, el) => 
      [...acc, ...el]
    , [])
}

function flatten_once(arr) {
  return arr.reduce(function(acc, el) {
    var str = Object.prototype.toString.call(schedules[0]);
    if (str == "[object Array]") {
      return [...acc, ...el];
    }
    else {
      return [...acc, el];
    }
  }, []);
}
