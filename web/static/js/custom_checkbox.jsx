import React from 'react';

export var CustomCheckbox = React.createClass({
  handleClick: function() {
    this.props.handleClick({
      trait: this.props.trait,
      ind: this.props.ind
    });
  },
  render: function() {
    var classname = "noselect checkbox " + (this.props.checked ? "checkbox-on" : "checkbox-off");
    return (
      <div className={classname}
        onClick={this.handleClick} >{this.props.text}</div>
    );
  }
});


